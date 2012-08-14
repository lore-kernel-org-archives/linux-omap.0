From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 09/13] OMAPDSS: SDI: Create a function to set timings
Date: Wed, 15 Aug 2012 00:38:34 +0530
Message-ID: <502AA232.1040305@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>   <1344512989-4071-1-git-send-email-archit@ti.com>   <1344512989-4071-10-git-send-email-archit@ti.com>  <1344951845.4845.58.camel@lappyti> <502A8322.6000309@ti.com> <1344965600.2345.70.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49973 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608Ab2HNTIo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 15:08:44 -0400
In-Reply-To: <1344965600.2345.70.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <rob@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tuesday 14 August 2012 11:03 PM, Tomi Valkeinen wrote:
> On Tue, 2012-08-14 at 22:26 +0530, Archit Taneja wrote:
>> On Tuesday 14 August 2012 07:14 PM, Tomi Valkeinen wrote:
>
>> I guess it depends on how drm/fb want to use it. I guess an output
>> should have a set_timings() kind of op if it can do it seamlessly. I
>> guess we can do that easily in DPI, for example, we could reduce the fps
>> from 60 to 30 without causing an artefacts(I think). For outputs which
>
> Yes, that kind of thing is easy to do by just changing the pck divider,
> which is in a shadow register. I mean, "easy" in theory, at least. Our
> clock calculation doesn't work like that currently, though, so it could
> end up changing DSS fck.
>
>> can't do it, we could remove the set_timings totally.
>
> But we do need set_timings for other outputs also (like sdi). We just
> can't change them just like that. Only outputs that do not need timings
> are DSI command mode and rfbi.
>
>> However, it'll be kind of inconsistent for some outputs to set timings,
>> and for others to not, and if in the future drm/fb gets exposed to ops
>> too, we may have dirty checks to see if set_timings is populated or not.
>>
>> The easiest way would be to make all set_timings just update the copy of
>> the timings output has, and expect drm/fb to disable and re enable the
>> panel. We may end up doing unnecessary gpio resets and configuration of
>> the panels though.
>
> I think changing things like timings is quite a rare operation. The only
> case it'd be necessary to change timings often, with speed, and without
> artifacts would be the fps drop you mentioned, for lower power use with
> panels that don't mind the fps drop.
>
> If I understood correctly, Rob said that drm already disables the output
> when changing the mode, when I asked if it's ok for the apply's
> set_timings to require the output to be off.
>
> In any case this is not a big issue, I mean, it's not causing any
> problems. Somebody is going to disable the output anyway when changing
> the timings. Perhaps even these patches are good, because they make the
> set_timings consistent across the output drivers (don't they?).

Yes, they do, there isn't a set_timings for RFBI though, only a 
set_size, and DSI has set_timings for video mode and a set_size for 
command mode, I haven't put checks in the ops for a panel driver to 
wrongly call set_timings in commmand mode, and set_size in video mode.

I haven't done that yet because a future patch of mine will have a DSI 
specific op called set_operation_mode() to make us independent of 
dssdev->panel.dsi_mode, there is no guarantee that the panel driver to 
first call set_operation_mode(), and then set_timings(), so I'm not sure 
yet how to deal with that. Probably having a mode/state which says that 
a field is unintialized might help, but that would overcomplicate things.

Archit

