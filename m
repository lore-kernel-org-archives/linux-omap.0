From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
Date: Wed, 23 Jan 2013 13:36:07 +0000
Message-ID: <20130123133607.GE2637@n2100.arm.linux.org.uk>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com> <1358894185-21617-2-git-send-email-robdclark@gmail.com> <20130123104216.1de2eee1@armhf> <CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53322 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab3AWNgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 08:36:17 -0500
Content-Disposition: inline
In-Reply-To: <CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, Jan 23, 2013 at 07:24:33AM -0600, Rob Clark wrote:
> On Wed, Jan 23, 2013 at 3:42 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > Hi Rob,
> >
> > As I wanted to re-use your nxp-tda998x driver for the Marvell Dove SoC,
> > I had a look at your IT LCD driver. Comments below.
> 
> Just fyi, you can re-use the nxp-tda998x part independently of tilcdc
> (just in case that wasn't clear).

Great, this chip is also used on the cubox too.

The one thing I wonder is how you deal with the VSYNC/HSYNC polarities
that are provided to the TDA9988x chip.  On the cubox, I have to adjust
the mode parameters such that the polarities are fixed up thusly:

        adjusted->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
                             DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC |
                             DRM_MODE_FLAG_PCSYNC | DRM_MODE_FLAG_NCSYNC);

        /* The TDA19988 always requires negative VSYNC? */
        adjusted->flags |= DRM_MODE_FLAG_NVSYNC;

        /* The TDA19988 requires positive HSYNC on 1080p or 720p */
        if ((adjusted->hdisplay == 1920 && adjusted->vdisplay == 1080) ||
            (adjusted->hdisplay == 1280 && adjusted->vdisplay == 720))
                adjusted->flags |= DRM_MODE_FLAG_PHSYNC;
        else
                adjusted->flags |= DRM_MODE_FLAG_NHSYNC;

        return true;

for these resolutions to be displayed correctly.

Also, when the only output is the HDMI device, reporting the display
"disconnected" and without any modes seems to cause problems - I have to
report "unknown" status when there's nothing connected, and also provide
a default (720p) mode when no EDID is received.
