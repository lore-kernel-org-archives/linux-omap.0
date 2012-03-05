From: Tony Lindgren <tony@atomide.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Mon, 5 Mar 2012 10:28:58 -0800
Message-ID: <20120305182858.GE12083@atomide.com>
References: <4F3E0EB7.9060803@ti.com>
 <874nuizfyf.fsf@ti.com>
 <4F4613B7.8010601@kynesim.co.uk>
 <4F4B9405.9070702@ti.com>
 <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
 <4F548CED.4090406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50263 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374Ab2CES3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 13:29:03 -0500
Content-Disposition: inline
In-Reply-To: <4F548CED.4090406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Richard Watts <rrw@kynesim.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120305 01:21]:
> On 02/28/2012 04:04 PM, Govindraj wrote:
> > The issue seems to a mux conflict issue, uart2_rx mux is been taken
> > by uart init and gpio_147 needed for usb phy init is not in mux mode4
> > as set by bootloader.
> > 
> > On beagle I see no other uarts being used other than uart3 as console_uart.
> > So I think it should be okay to init only uart3 from beagle board data.
> > Here is the patch [1] to do the same. (Tested on Beagle Xm Rev.C)
> > 
> > (Any other approach is welcome)
> 
> Thank you, I have working ethernet port finally!!!
> 
> > From f1b43f983a2926c637e6bc6ab5d1e5044339ffd3 Mon Sep 17 00:00:00 2001
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> > Date: Tue, 28 Feb 2012 19:16:33 +0530
> > Subject: [PATCH] omap3_beagle: Init only uart3 used for console
> > 
> > On beagle some of uart mux lines are used for other
> > purpose so init only uart3.
> > 
> > Uart2 rx line clashes with gpio_147 used for usb ehci
> > phy reset.
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks applying into board branch.

Regards,

Tony
