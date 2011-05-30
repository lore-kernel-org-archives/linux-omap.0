From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Error while rotating LCD fb - detected fb_set_par error, error
 code: -22
Date: Mon, 30 May 2011 09:49:42 +0300
Message-ID: <1306738182.2117.31.camel@deskari>
References: <4DDF788B.5030906@gmail.com>  <4DDFB591.1090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56015 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab1E3Gtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 02:49:49 -0400
Received: by eyx24 with SMTP id 24so1257452eyx.19
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 23:49:47 -0700 (PDT)
In-Reply-To: <4DDFB591.1090807@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohamed Thalib H <hmthalib@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Fri, 2011-05-27 at 20:00 +0530, Mohamed Thalib H wrote:
> On Friday 27 May 2011 03:40 PM, Mohamed Thalib H wrote:
> > Hi,
> >
> > I am using a omap3530 
> > <http://focus-webapps.ti.com/general/docs/sitesearch/searchdevice.tsp?partNumber=omap3530> 
> > based board. I am trying to rotate the LCD 
> > using*/sys/class/graphics/fb0/rotate*. The rotation works only for 0 
> > degree and 270 degrees.
> >
> > When trying to rotate for 90 or 180 degree it give error message 
> > *detected fb_set_par error, error code: -22 *and does not rotate.
> >
> > The log output is below.*
> > *
> >
> > / # cat /proc/cmdline
> > omapdss.def_disp=lcd30 console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw 
> > rootfstype=ext3
> >  rootwait lpj=1949696 omapfb.rotate=1 omapfb.rotate_type=1 
> > omap_vout.vid1_static_vrf
> > b_alloc=y omapfb.vrfb=y
> > / # echo "0" > /sys/class/graphics/fb0/rotate
> > detected fb_set_par error, error code: -22
> > / # echo "1" > /sys/class/graphics/fb0/rotate
> > / # echo "2" > /sys/class/graphics/fb0/rotate
> > detected fb_set_par error, error code: -22
> > / # echo "3" > /sys/class/graphics/fb0/rotate
> > / # echo "1" > /sys/class/graphics/fb0/rotate
> >
> > Can some one help me in solving this issue.
> >
> > Regards,
> > HM Thalib
> >
> 
> For you info I am using 2.6.34 kernel. LCD size is 240x480
> 
> While tracing though the source code I have found out that in file 
> *drivers/video/omap2/dss/overlay.c *function *dss_check_overlay() *it is 
> checking if *dw < info->pos_x + outw *which is *(240 < 0 + 400)*
> 
> that is if my overlay width is smaller than screen size, if so return 
> error.
> 
> Have any one faced the same scenario.  If I am doing something wrong, 
> Please let me know the correct steps to rotate the screen.

The driver does not resize the framebuffer for you. You need to resize
and redraw it.

It's been a while since I used rotation, but something like this should
work:

- disable the overlay
- resize the framebuffer
- resize the overlay (could be done automatically in the previous step)
- set rotation
- enable overlay

For testing purposes you may also want to try a square framebuffer
(240x240), in which case you can rotate it freely as it always fits in
the screen.

Also, you're using quite an old kernel. I suggest using newer, if
possible. 

 Tomi


