From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 02:35:10 -0600
Message-ID: <CAF6AEGtQqn3jpDMRDeCrDA8p_EEAG5=NhRh8uhmfs6haboAE5g@mail.gmail.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<1337839294.2764.7.camel@lappyti>
	<CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	<1337843144.2909.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34421 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2EXIfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 04:35:11 -0400
Received: by vbbff1 with SMTP id ff1so5263887vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 01:35:10 -0700 (PDT)
In-Reply-To: <1337843144.2909.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, May 24, 2012 at 1:05 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Thu, 2012-05-24 at 00:27 -0600, Clark, Rob wrote:
>> On Thu, May 24, 2012 at 12:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.=
com> wrote:
>> > Hi,
>> >
>> > On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
>> >> Register OMAP DRM/KMS platform device. =A0DMM is split into a
>> >> separate device using hwmod.
>> >>
>> >> Signed-off-by: Andy Gross <andy.gross@ti.com>
>> >
>> > <snip>
>> >
>> >> +static int __init omap_init_drm(void)
>> >> +{
>> >> + =A0 =A0 struct omap_hwmod *oh =3D NULL;
>> >> + =A0 =A0 struct platform_device *pdev;
>> >> +
>> >> + =A0 =A0 /* lookup and populate the DMM information, if present =
- OMAP4+ */
>> >> + =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
>> >> +
>> >> + =A0 =A0 if (oh) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D omap_device_build(oh->name, -1=
, oh, NULL, 0, NULL, 0,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 false);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build oma=
p_device for %s\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name);
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return platform_device_register(&omap_drm_device);
>> >> +
>> >> +}
>> >
>> > I still don't like fixing the tiler to drm. I would like to have b=
asic
>> > tiler support in omapfb also, but with this approach I'll need to
>> > duplicate the code. And even if we disregard omapfb, wouldn't it b=
e
>> > architecturally better to have the tiler as a separate independent
>> > library/driver?
>>
>> Not easily, at least not if we want to manage to use tiler/dmm in a
>> more dynamic way, or to enable some additional features which are
>> still on the roadmap (like reprogramming dmm synchronized w/ scanout=
,
>> or some things which are coming if future hw generations). =A0We nee=
d
>> one place to keep track of which buffers are potentially evictable t=
o
>> make room for mapping a new buffer. =A0And if you look at the tricks
>> that go on with mmap'ing tiled buffers to userspace, you *really*
>> don't want to duplicate that in N different drivers.
>
> So why can't all that code be in a tiler library/driver?

Possibly the placement stuff could be in a library..  the
mmap/faulting stuff I think would be harder to split.  With it split
out in a separate lib, it becomes logistically a bit more of a
headache to change APIs, etc.  Basically it just makes more work and
is unnecessary.

>> Fortunately with dmabuf there is not really a need for N different
>> drivers to need to use tiler/dmm directly. =A0The dmabuf mechanism
>> provides what they need to import GEM buffers from omapdrm. =A0That =
may
>> not really help omapfb because fbdev doesn't have a concept of
>> importing buffers. =A0But OTOH this is unnecessary, because drm prov=
ides
>> an fbdev interface for legacy apps. =A0The best thing I'd recommend =
is,
>> if you miss some features of omapfb in the drm fbdev implementation,
>> is to send some patches to add this missing features.
>
> Well, at least currently omapfb and omapdrm work quite differently, i=
f
> I've understood right. Can we make a full omapfb layer on top of
> omapdrm? With multiple framebuffers mapped to one or more overlays,
> support for all the ioctls, etc?

Well, there is still room to add your own fb_ioctl() fxn, so I guess
in principle it should be possible to add whatever custom ioctls are
required.

Typically you have a single fbdev device for a single drm device,
although I suppose nothing prevents creating more.  I'd probably want
to encourage users more towards using KMS directly for multi-display
cases because you have a lot more options/flexibility that way.

> I guess we'd still need to have omapfb driver to keep the module
> parameters and behavior the same. Can omapdrm be used from inside the
> kernel by another driver?

Hmm, I'm not quite sure what you have in mind, but it sounds a bit
hacky..  I'd guess if you need 100% backwards compatibility even down
to kernel cmdline / module params, then you probably want to use
omapfb.  But there isn't really need to add new features to omapfb in
that case.

Off the top of my head, I guess that 80-90% compatibility would
probably be reasonable to add to omapdrm's fbdev..  and that the last
10-20% would be too hacky/invasive to justify adding to omapdrm.

BR,
-R

> =A0Tomi
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
