From: Arun C <arunedarath@mistralsolutions.com>
Subject: RE: Problem with configuring the LCD in VGA mode
Date: Mon, 10 Mar 2008 16:12:45 +0530
Message-ID: <1205145765.3632.23.camel@localhost.localdomain>
References: <1204973168.4869.23.camel@localhost.localdomain>
	 <7EAD1AEEA7621C45899FE99123E124A0017572F9@dbde01.ent.ti.com>
Reply-To: arunedarath@mistralsolutions.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway.mistralsoftware.com ([220.227.112.130]:4376 "EHLO
	Mistralsoftware.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750802AbYCJKtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 06:49:01 -0400
Received: from [192.168.13.42] by mistralsolutions.com (MDaemon PRO v9.6.4)
	with ESMTP id 29-md50000008115.msg
	for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2008 16:19:09 +0530
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0017572F9@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

Hi,

Thanks Syed Khasim for the reply,

> For VGA LCD on 3430SDP we have configured DSS for 
>          left_margin     = 79,           /* pixclocks */
>          right_margin    = 89,           /* pixclocks */
>          upper_margin    = 1,            /* line clocks */
>          lower_margin    = 0,            /* line clocks */
>          hsync_len       = 3,            /* pixclocks */
>          vsync_len       = 2,            /* line clocks */
>          sync            = 1,            /* hsync & vsync polarity */
>          acb             = 0x28,         /* AC-bias pin frequency */
>          ipc             = 1,            /* Invert pixel clock */
>          onoff           = 1;            /* HSYNC/VSYNC Pixel clk Control*/
> 

I tried with the above values and i am still getting irq errors(gfx
underflow).

The timings corresponding to above values are given below

mode "480x640-49"
        # D: 20.600 MHz, H: 31.644 kHz, V: 49.213 Hz
        geometry 480 640 480 640 16
        timings 48543 89 79 0 1 3 2
        accel false
        rgba 5/11,6/5,5/0,0/0
endmode

DSS1fclk is at 82.5 Mhz and my prcm settings is PRCM 3 ( Clocking rate
(Crystal/DPLL/MPU): 13.0/660/330 MHz).

That means my dss1Iclk is 110Mhz (L3 is also 110Mhz) is this making any
problem??


> > As with these settings my pixel clock is set to 18.3Mhz and LCD comes up
> > with the linux logo.
> > 
> What is the pixel clock required by LCD? Make your FCLK 4 times the pixel clock.
My lcd datasheet says minimum 23 MHz and maximum 26 MHz. But now my
pixel clock is 20Mhz and FCLK is 82.5 (82.5 > 20*4). Is this enough??

> The FIFO settings needs to be adjusted as well, the difference between upper and lower threshold can be made equal to burst size. And keep the high threshold to 0xff.
> 
This is matching in my case( burst = 16 X 32 , high= 0xFF ,low =0xC0) 

> > If i keep DSS1fclk=55Mhz and pixel_clock=5000 it works without any
> > problem but the vfreq( vertical refresh rate) is very too low for
> > decent viewing in VGA mode.
> > 
> 5000? 

Yes in the git kernel this 5000 is multiplied by 1000 for setting pixel
clock.

Regards,
Arun c


-------------------------------------------------------DISCLAIMER------------------------------------------------------
The information transmitted herewith is confidential and proprietary information intended only for use by the individual or entity to which it is addressed. If the reader of this message is not the intended recipient, you are hereby notified that any review, retransmission, dissemination, distribution, copying or other use of, or taking of any action in reliance upon this information is strictly prohibited. If you have received this communication in error, please contact the sender and delete the material from your computer.
--------------------------------------------------------------------------------------------------------------------------------

Please do not print this email unless it is absolutely necessary. Spread environmental awareness.


