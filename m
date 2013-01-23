From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
Date: Wed, 23 Jan 2013 08:13:43 -0600
Message-ID: <CAF6AEGu2f_zqkKayS-7ZEiVHHEhEYcqE2eL2BQ4rxW6+08wm7w@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-2-git-send-email-robdclark@gmail.com>
	<20130123104216.1de2eee1@armhf>
	<CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
	<20130123133607.GE2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:39836 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab3AWONo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 09:13:44 -0500
Received: by mail-vb0-f52.google.com with SMTP id fa15so4735135vbb.11
        for <linux-omap@vger.kernel.org>; Wed, 23 Jan 2013 06:13:43 -0800 (PST)
In-Reply-To: <20130123133607.GE2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, Jan 23, 2013 at 7:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 23, 2013 at 07:24:33AM -0600, Rob Clark wrote:
>> On Wed, Jan 23, 2013 at 3:42 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
>> > Hi Rob,
>> >
>> > As I wanted to re-use your nxp-tda998x driver for the Marvell Dove SoC,
>> > I had a look at your IT LCD driver. Comments below.
>>
>> Just fyi, you can re-use the nxp-tda998x part independently of tilcdc
>> (just in case that wasn't clear).
>
> Great, this chip is also used on the cubox too.

cool, it would be great if other platforms could benefit from this as
well.. the out-of-tree nxp driver is just horrid ;-)

> The one thing I wonder is how you deal with the VSYNC/HSYNC polarities
> that are provided to the TDA9988x chip.  On the cubox, I have to adjust
> the mode parameters such that the polarities are fixed up thusly:
>
>         adjusted->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
>                              DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC |
>                              DRM_MODE_FLAG_PCSYNC | DRM_MODE_FLAG_NCSYNC);
>
>         /* The TDA19988 always requires negative VSYNC? */
>         adjusted->flags |= DRM_MODE_FLAG_NVSYNC;
>
>         /* The TDA19988 requires positive HSYNC on 1080p or 720p */
>         if ((adjusted->hdisplay == 1920 && adjusted->vdisplay == 1080) ||
>             (adjusted->hdisplay == 1280 && adjusted->vdisplay == 720))
>                 adjusted->flags |= DRM_MODE_FLAG_PHSYNC;
>         else
>                 adjusted->flags |= DRM_MODE_FLAG_NHSYNC;
>
>         return true;
>
> for these resolutions to be displayed correctly.

hmm, I didn't come across this.  Although 1080p seems to be a bit more
than what the little board I'm working on can drive.  I didn't have to
do any special fixup for 720p..

I wonder if you are having to do that with the nxp out of tree driver?
 Maybe it is related to how that driver it is configuring the hw?  It
would be interesting if you hit the same issue w/ the i2c encoder
slave version.

At any rate, if it turns out to be needed, we can add this in
tda998x_encoder_mode_fixup().

> Also, when the only output is the HDMI device, reporting the display
> "disconnected" and without any modes seems to cause problems - I have to
> report "unknown" status when there's nothing connected, and also provide
> a default (720p) mode when no EDID is received.

hmm, also did not run into any issues here on my end.  What sort of
problems did you hit?

BR,
-R
