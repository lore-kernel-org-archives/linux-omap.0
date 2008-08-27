From: "iqbal" <iqbal@ti.com>
Subject: Re: omapfb problem on 3430sdp
Date: Wed, 27 Aug 2008 19:39:11 +0530 (IST)
Message-ID: <38415.192.168.10.89.1219846151.squirrel@dbdmail.itg.ti.com>
References: <1219829316.15818.77.camel@localhost>
    <20080827094318.GB9340@gandalf.research.nokia.com>
    <1219842228.15818.97.camel@localhost>
    <20080827133217.GA7354@gandalf.research.nokia.com>
Reply-To: iqbal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59903 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761551AbYH0OJZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Aug 2008 10:09:25 -0400
In-Reply-To: <20080827133217.GA7354@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "ext stanley.miao" <stanley.miao@windriver.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org


Stanley,

>> In the file omap_disp_out.c in omapzoom.org :
>>
>>  113 #define LCD_PANEL_ENABLE_GPIO           5
>>  114 #define LCD_PANEL_BACKLIGHT_GPIO        8
>>
>> In the file lcd_2430sdp.c in linux-omap-2.6:
>>
>>  35 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO        24
>>  36 #define SDP3430_LCD_PANEL_ENABLE_GPIO           28

Both 5-8 and 24-28 GPIO combinations work fine on 3430sdp ES 2.0.
According to TRM 5-8 are the right ones for ES 2.0. One of my patches on
linux-omap had these changes but it didn't through.

>
> different board revisions, maybe ?
>
> I think mvista.com will have support for es2.0, although it would be
> nice to check the revision and change the gpio numbers based on that.
>
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


