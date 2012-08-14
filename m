From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2 09/13] OMAPDSS: SDI: Create a function to set timings
Date: Tue, 14 Aug 2012 14:26:06 -0500
Message-ID: <CAF6AEGuNJX0BVhaf6mJ-yQnOiZ3gDpUbK2_B7bZwWS4SjKB+ew@mail.gmail.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	<1344512989-4071-1-git-send-email-archit@ti.com>
	<1344512989-4071-10-git-send-email-archit@ti.com>
	<1344951845.4845.58.camel@lappyti>
	<502A8322.6000309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57278 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab2HNT0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 15:26:06 -0400
In-Reply-To: <502A8322.6000309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Aug 14, 2012 at 11:56 AM, Archit Taneja <archit@ti.com> wrote:
> On Tuesday 14 August 2012 07:14 PM, Tomi Valkeinen wrote:
>>
>> On Thu, 2012-08-09 at 17:19 +0530, Archit Taneja wrote:
>>>
>>> Create function omapdss_sdi_set_timings(). Configuring new timings is
>>> done the
>>> same way as before, SDI is disabled, and re-enabled with the new timings
>>> in
>>> dssdev. This just moves the code from the panel drivers to the SDI
>>> driver.
>>>
>>> The panel drivers shouldn't be aware of how SDI manages to configure a
>>> new set
>>> of timings. This should be taken care of by the SDI driver itself.
>>
>>
>> I'm not sure about this one. Although I see that dpi.c does currently
>> the same thing as you're doing in your patch.
>
>
> Even HDMI does the same thing.
>
>
>>
>> One thing is that we should try to remove dssdev uses from the output
>> drivers, including use of dssdev->state.
>
>
> Yes, we could do that by keeping a state of the output(and also checking
> state of the manager)
>
>
>>
>> The other thing is that I don't think the output driver should disable &
>> enable the output during set timings. I think sdi's set_timings should
>> return EBUSY if the output is enabled. The same way as other
>> configuration functions should (like dpi_set_data_lines or such).
>>
>> I'm actually not sure if even the panel driver should disable & enable
>> the output during set_timings. Perhaps it should be the caller's
>> (omapdrm or such) responsibility....
>>
>> My reasoning here is that disabling & enabling the video output is not
>> invisible to the upper layers, so doing it "in secret" may be bad.
>>
>> Then again, perhaps timings can be changed freely on some other
>> platforms, and then it'd be nice if the panel driver wouldn't disable &
>> enable the output.
>>
>> So I'm again not quite sure what's the best way to handle this... (of
>> the dssdev->state I'm sure, its use should be removed from omapdss). Any
>> thoughts?
>
>
> I guess it depends on how drm/fb want to use it. I guess an output should
> have a set_timings() kind of op if it can do it seamlessly. I guess we can
> do that easily in DPI, for example, we could reduce the fps from 60 to 30
> without causing an artefacts(I think). For outputs which can't do it, we
> could remove the set_timings totally.

fwiw, drm wouldn't try to change timings on the fly..  or at least it
is bracketed by a call to the driver's crtc->prepare() and
crtc->commit() fxns (which in our case disable/enable output).

I haven't seen much userspace that tries to do things like this,
except maybe some apps like xbmc which seem to have some options to
attempt to change timings to align w/ video playback framerate.  I am
a bit curious how many tv's and drivers could support this in a
glitch-free way.

BR,
-R

> However, it'll be kind of inconsistent for some outputs to set timings, and
> for others to not, and if in the future drm/fb gets exposed to ops too, we
> may have dirty checks to see if set_timings is populated or not.
>
> The easiest way would be to make all set_timings just update the copy of the
> timings output has, and expect drm/fb to disable and re enable the panel. We
> may end up doing unnecessary gpio resets and configuration of the panels
> though.
>
> Archit
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
