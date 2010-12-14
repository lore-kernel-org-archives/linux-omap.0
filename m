From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Fwd: possible errors in linux omap display headers - who would
 be a good person to contact?
Date: Tue, 14 Dec 2010 13:29:46 +0200
Message-ID: <1292326186.6893.94.camel@tubuntu>
References: <AANLkTimZ_zDeNQxXX7irP+-BiMe=QoTm-tLnFz=AWof3@mail.gmail.com>
	 <AANLkTi=Ltd28K6Ch2xWE1NnWKcrqOwdiurgZZGjUth7S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:57532 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984Ab0LNL3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 06:29:51 -0500
In-Reply-To: <AANLkTi=Ltd28K6Ch2xWE1NnWKcrqOwdiurgZZGjUth7S@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Chethan Pandarinath <chethan.pandarinath@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, 2010-12-13 at 15:26 -0500, ext Chethan Pandarinath wrote:
> Hi Tomi,
> 
> 
> I sent the below email to the angstrom linux development listserv.
> Based on the Maintainers list from git.kernel.org, you seem like the
> right person to contact about this. Would you be able to discuss this
> with me?
> 
> 
> Thanks.
> Chethan
> 
> ---------- Forwarded message ----------
> From: Chethan Pandarinath <chethan.pandarinath@gmail.com>
> Date: Mon, Dec 13, 2010 at 2:34 PM
> Subject: possible errors in linux omap display headers - who would be
> a good person to contact?
> To: angstrom-distro-devel <angstrom-distro-devel@linuxtogo.org>
> 
> 
> Hi everybody, this may not be the right place to ask this question,
> but I don't really know who to address it to, so maybe someone here
> can point me in the right direction.
> 
> 
> I have been working on setting up a video framebuffer and writing to
> it on an OMAP 3530 device (TI beagleboard). It appears that the
> definitions in drivers/video/omap/omapfb.h are incorrect (possibly out
> of date?), which caused a lot of confusion while trying to set up my
> framebuffer.
> 
> 
> Specifically, I'm trying to set the properties of my framebuffer,
> using the ioctl command, FBIOPUT_VSCREENINFO, and a fb_var_screeninfo
> struct.
> 
> 
> The fb_var_screeninfo struct has a parameter nonstd that sets the
> color properties of the buffer (e.g. RGB 565, RGB 24U, YUV 422, etc). 
> 
> 
> The acceptable values for nonstd are defined in the omapfb.h file, but
> they appear to be incorrect - at least they don't seem to set the
> parameters of the buffer the way one would expect. For example,
> using OMAPFB_COLOR_RGB565 appears to give me a buffer with parameters
> that look like OMAPFB_COLOR_RGB24U.

nonstd field is only used for OMAPFB_COLOR_YUV422 and
OMAPFB_COLOR_YUY422. For other modes leave it to zero.

If you want to use YUV modes, set the nonstd to the yuv mode, and
bits_per_pixel to 16.

For other modes, set bits_per_pixel and red/green/blue/transp fields. 

You can look at drivers/video/omap2/omapfb/omapfb-main.c
omapfb_colormodes[] array for examples how the driver parses the modes.

 Tomi



