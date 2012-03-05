From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Mon, 05 Mar 2012 11:52:45 +0200
Message-ID: <4F548CED.4090406@ti.com>
References: <4F3E0EB7.9060803@ti.com> <874nuizfyf.fsf@ti.com> <4F4613B7.8010601@kynesim.co.uk> <4F4B9405.9070702@ti.com> <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45319 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756418Ab2CEJwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 04:52:42 -0500
Received: by lahe6 with SMTP id e6so5869640lah.32
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 01:52:39 -0800 (PST)
In-Reply-To: <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Richard Watts <rrw@kynesim.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

On 02/28/2012 04:04 PM, Govindraj wrote:
> The issue seems to a mux conflict issue, uart2_rx mux is been taken
> by uart init and gpio_147 needed for usb phy init is not in mux mode4
> as set by bootloader.
> 
> On beagle I see no other uarts being used other than uart3 as console_uart.
> So I think it should be okay to init only uart3 from beagle board data.
> Here is the patch [1] to do the same. (Tested on Beagle Xm Rev.C)
> 
> (Any other approach is welcome)

Thank you, I have working ethernet port finally!!!

> From f1b43f983a2926c637e6bc6ab5d1e5044339ffd3 Mon Sep 17 00:00:00 2001
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Tue, 28 Feb 2012 19:16:33 +0530
> Subject: [PATCH] omap3_beagle: Init only uart3 used for console
> 
> On beagle some of uart mux lines are used for other
> purpose so init only uart3.
> 
> Uart2 rx line clashes with gpio_147 used for usb ehci
> phy reset.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

