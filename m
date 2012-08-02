From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Thu, 2 Aug 2012 07:45:21 -0500
Message-ID: <CAF6AEGuCTu_KtH-G+gQDA=2pmKtbsoe5k8m78=bJT6cRDVFm0A@mail.gmail.com>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	<1343742034.2633.56.camel@deskari>
	<CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	<1343812870.2645.37.camel@deskari>
	<CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
	<1343891600.5767.12.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33543 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab2HBMpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 08:45:22 -0400
Received: by vbbff1 with SMTP id ff1so8043363vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 05:45:21 -0700 (PDT)
In-Reply-To: <1343891600.5767.12.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Thu, Aug 2, 2012 at 2:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Wed, 2012-08-01 at 09:25 -0500, Rob Clark wrote:
>> On Wed, Aug 1, 2012 at 4:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>> > I guess the fact is that DRM concepts do not really match the OMAP DSS
>> > hardware, and we'll have to use whatever gives us least problems.
>>
>> Actually, I think it does map fairly well to the hardware.. at least
>> more so than to omapdss ;-)
>
> Hm, I'm not sure I understand, omapdss concepts map directly to the
> hardware.

I think it is mainly exposing the encoder and panel as two separate
entities.. which seems to be what Archit is working on

in case of something like DVI bridge from DPI, this seems pretty
straightforward.. only the connector needs to know about DDC stuff,
which i2c to use and that sort of thing.  So at kms level we would
have (for example) an omap_dpi_encoder which would be the same for DPI
panel (connector) or DPI->DVI bridge.  For HDMI I'm still looking
through the code to see how this would work.  Honestly I've looked
less at this part of code and encoder related registers in the TRM,
compared to the ovl/mgr parts, but at least from the 'DSS overview'
picture in the TRM it seems to make sense ;-)

KMS even exposes the idea that certain crtcs can connect to only
certain encoders.  Or that you could you could have certain connectors
switched between encoders.  For example if you had a hw w/ DPI out,
and some mux to switch that back and forth between a DPI lcd panel and
a DPI->DVI bridge.  (Ok, I'm not aware of any board that actually does
this, but it is in theory possible.)  So we could expose possible
video chain topologies to userspace in this way.

The other thing is that we don't need to propagate timings from the
panel up to the mgr at the dss level.. kms is already handling this
for us.  In my latest version, which I haven't pushed, I removed the
'struct omap_overlay_mgr' ptr from 'struct omap_dss_device'.

>> The one area that kms mismatches a bit is decoupling of ovl from mgr
>> that we have in our hw..  I've partially solved that a while back w/
>
> What do you mean with that? Ovls and mgrs are one entity in KMS? Didn't
> the drm_plane stuff separate these?

yes and no.. it is in our omapdrm implementation, because each crtc
has it's own private plane assigned.  Basically the purpose is that we
can't break the interface to existing KMS userspace, which expects a
CRTC to include the dma scanout engine.  But it means at the moment we
can't re-use these planes from crtc's that are not in use.

I have some ideas about how to expose this to userspace in a backwards
compatible way, so a userspace that is aware of this can re-use planes
from crtcs that are not in use.  There is at least one other SoC
platform (STE, IIRC?) that has similar flexibility in hw, so I think
this is a worthwhile thing to do.. but just haven't gotten to it yet.

>> For enabling/disabling an output (manager+encoder), this is relatively
>> infrequent, so it can afford to block to avoid races.  (Like userspace
>> enabling and then rapidly disabling an output part way through the
>> enable.)  But enabling/disabling an overlay, or adjusting position or
>> scanout address must not block.  And ideally, if possible, switching
>> an overlay between two managers should not block.
>
> Adjusting the position or address of the buffer are simple, they can be
> easily done without any blocking.
>
> But ovl enable/disable and switching an ovl to another mgr do (possibly)
> take multiple vsyncs (and in the switch case, vsyncs of two separate
> outputs). So if those do not block, we'll need to handle them as a state
> machine and try to avoid races etc. It'll be "interesting".

ok, I see the problem.  Really the one thing I'm not handling properly
is disconnecting a plane from one crtc and connecting to another.  The
disconnect should synchronize on the outgoing crtc's vblank/GO, and
connect on the incoming crtc.  But this is not a frequent operation,
so I think the easy solution here is to block on the
connect-to-new-crtc if the disconnect is still pending.  I'd prefer
this to introducing intermediate states.

A simple enable/disable without changing crtc does not need to block.
If usespace disables and then re-enables before the vblank, we just
apply whatever is the most recent state at the vblank.  Meaning
enable->disable->enable, the middle disable might just get skipped.
This is fine, and actually desirable.

> However, we can sometimes do those operations immediately. So I think we
> should have these conditional fast-paths in the code, and do them in
> non-blocking manner when possible.
>
>> I'll look again, but as far as I remember that at least wasn't
>> addressing the performance issues from making overlay enable/disable
>
> Right, it wasn't addressing those issues. But your branch doesn't really
> address those issues either, as it doesn't handle the problems related
> to ovl enable/disable.
>
>> synchronous.  And fixing that would, I expect, trigger the same
>> problems that I already spent a few days debugging before switching
>> over to handle apply in omapdrm.
>
> I was under the impression that the apply mechanism, the caching and
> setting of the configs, was the major issue you had. But you're hinting
> that the actual problem is related to ovl enable/disable? I haven't
> tried fixing the ovl enable/disable, as I didn't know it's an issue for
> omapdrm. Or are they both as big issues?

I think the problem was there were some cases, like ovl updates before
setting the mgr, where the user_info_dirty flag would be cleared but
the registers not updated.  This is what I meant by sequence of
operations at KMS level confusing omapdss.  This should be fixable
with some debugging.  Although getting rid of the state tracking at
omapdss level altogether was a much simpler solution, and is the one I
prefer :-)

BR,
-R

>  Tomi
>
