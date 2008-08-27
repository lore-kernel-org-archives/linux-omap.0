From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: omapfb problem on 3430sdp
Date: Wed, 27 Aug 2008 16:32:17 +0300
Message-ID: <20080827133217.GA7354@gandalf.research.nokia.com>
References: <1219829316.15818.77.camel@localhost> <20080827094318.GB9340@gandalf.research.nokia.com> <1219842228.15818.97.camel@localhost>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61217 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbYH0Nc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 09:32:26 -0400
Content-Disposition: inline
In-Reply-To: <1219842228.15818.97.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext stanley.miao" <stanley.miao@windriver.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, Aug 27, 2008 at 09:03:47PM +0800, ext stanley.miao wrote:
> I updated the kernel again. Now the kernel from omapzoom.org is OK, but
> the kernel from "source.mvista.com/git/linux-omap-2.6.git" still can't
> work.
> 
> The LCD drivers in omapzoom.org and in linux-omap-2.6 use different
> files.  the LCD driver in omapzoom.org is omap_disp_out.c and omap_fb.c
> while the driver in linux-omap-2.6 is lcd_2430sdp.c and omapfb_main.c.
> 
> The following MACRO are defined differently. Can anyone tell me why ?
> 
> In the file omap_disp_out.c in omapzoom.org :
> 
>  113 #define LCD_PANEL_ENABLE_GPIO           5
>  114 #define LCD_PANEL_BACKLIGHT_GPIO        8
> 
> In the file lcd_2430sdp.c in linux-omap-2.6:
> 
>  35 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO        24
>  36 #define SDP3430_LCD_PANEL_ENABLE_GPIO           28

different board revisions, maybe ?

I think mvista.com will have support for es2.0, although it would be
nice to check the revision and change the gpio numbers based on that.

-- 
balbi
