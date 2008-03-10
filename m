From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Problem with configuring the LCD in VGA mode
Date: Mon, 10 Mar 2008 13:42:56 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017572F9@dbde01.ent.ti.com>
References: <1204973168.4869.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34123 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbYCJINZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 04:13:25 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1204973168.4869.23.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunedarath@mistralsolutions.com, linux-omap@vger.kernel.org

Hi Arun,
 
> I changed the following parameters for VGA mode keeping DSS1fclk at
> 55MHz
> 
>         .x_res          = 480,
>         .y_res          = 640,
>         .hsw            = 2,
>         .hfp            = 0,
>         .hbp            = 28,
>         .vsw            = 1,
>         .vfp            = 2,
>         .vbp            = 0,
>         .pixel_clock    = 20000,
> 

For VGA LCD on 3430SDP we have configured DSS for 
         left_margin     = 79,           /* pixclocks */
         right_margin    = 89,           /* pixclocks */
         upper_margin    = 1,            /* line clocks */
         lower_margin    = 0,            /* line clocks */
         hsync_len       = 3,            /* pixclocks */
         vsync_len       = 2,            /* line clocks */
         sync            = 1,            /* hsync & vsync polarity */
         acb             = 0x28,         /* AC-bias pin frequency */
         ipc             = 1,            /* Invert pixel clock */
         onoff           = 1;            /* HSYNC/VSYNC Pixel clk Control*/

> As with these settings my pixel clock is set to 18.3Mhz and LCD comes up
> with the linux logo.
> 
What is the pixel clock required by LCD? Make your FCLK 4 times the pixel clock.

> But if I try to display continuously to frame buffer lcd flickers and
> gfxfifo underflow irq occurs frequently.
>
The FIFO settings needs to be adjusted as well, the difference between upper and lower threshold can be made equal to burst size. And keep the high threshold to 0xff.

 
> I tried increasing DSS1fclk to 82.5 (660Mhz/8) still gfxfifo
> underflows.
> 
> If i keep DSS1fclk=55Mhz and pixel_clock=5000 it works without any
> problem but the vfreq( vertical refresh rate) is very too low for
> decent viewing in VGA mode.
> 
5000? 

> Any body faced this issue?? Please help me to solve this problem.

Regards,
Khasim
