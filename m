From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: omapfb problem on 3430sdp
Date: Wed, 27 Aug 2008 21:03:47 +0800
Message-ID: <1219842228.15818.97.camel@localhost>
References: <1219829316.15818.77.camel@localhost>
	 <20080827094318.GB9340@gandalf.research.nokia.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41620 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246AbYH0NCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Aug 2008 09:02:12 -0400
In-Reply-To: <20080827094318.GB9340@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

I updated the kernel again. Now the kernel from omapzoom.org is OK, but
the kernel from "source.mvista.com/git/linux-omap-2.6.git" still can't
work.

The LCD drivers in omapzoom.org and in linux-omap-2.6 use different
files.  the LCD driver in omapzoom.org is omap_disp_out.c and omap_fb.c
while the driver in linux-omap-2.6 is lcd_2430sdp.c and omapfb_main.c.

The following MACRO are defined differently. Can anyone tell me why ?

In the file omap_disp_out.c in omapzoom.org :

 113 #define LCD_PANEL_ENABLE_GPIO           5
 114 #define LCD_PANEL_BACKLIGHT_GPIO        8

In the file lcd_2430sdp.c in linux-omap-2.6:

 35 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO        24
 36 #define SDP3430_LCD_PANEL_ENABLE_GPIO           28


Why are they defined differently?

Thanks
Stanley.


On Wed, 2008-08-27 at 12:43 +0300, Felipe Balbi wrote:
> On Wed, Aug 27, 2008 at 05:28:36PM +0800, ext stanley.miao wrote:
> > Hardware: 
> > 	Mainboard: 750-2094-001(C)
> > 	Display board: 750-2081-101(B)
> > 
> > Software: 
> > 	the lastest kernel from linux-omap-2.6 and from omapzoom.org.
> > 
> > The linux bootup logo is green, and LCD is dark. It looks like backlight
> > disabled. 
> > 
> > I commented the following two sentences in lcd_2430.c, there is still
> > the same thing. It seems these two sentences doesn't work.
> > 
> >  96         omap_set_gpio_dataout(enable_gpio, 1);
> >  97         omap_set_gpio_dataout(backlight_gpio, 1);
> > 
> > Both the the latest kernels from omapzoom.org and linux-omap-2.6 have
> > this problem.  However, the old version in linux-omap-2.6, 2.6.21,
> > doesn't have this problem.
> 
> Cool could you bisect and try to find the commit that broke it ?
> 
> $ git bisect start
> $ git bisect good v2.6.21-omap1
> $ git bisect bad
> 
> Should help you. Read git help bisect for more information. When you
> find the exact commit that broke lcd_2430.c, report here with the commit
> id.
> 
> Just a note, if you can't build the bisect point, reset to some points
> before and try again until you find a commit that builds, do not mark
> them as bad.
> 
