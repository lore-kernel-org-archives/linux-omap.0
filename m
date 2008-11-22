From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: busybox output to display
Date: Sat, 22 Nov 2008 16:42:09 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A445D1E2@dlee07.ent.ti.com>
References: <9e6474ae0811221135l1a3fcf93gb59d12407c57ecfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYKVWmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 17:42:17 -0500
In-Reply-To: <9e6474ae0811221135l1a3fcf93gb59d12407c57ecfc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sudipta GHOSH <sudipta.in@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

We accidentally saw this behavior when saving bootargs like:

"setenv bootargs='...'" instead of "setenv bootargs '...'"

Try removing '='

Misa

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sudipta GHOSH
> Sent: Saturday, November 22, 2008 1:35 PM
> To: linux-omap@vger.kernel.org
> Subject: busybox output to display
> 
> Hi,
> 
> This issue is more with busybox. Hope you will not mind for posting here.
> 
> In my development board, I use uboot as boot loader. busybox files are in
> flash.
> when I boot , I can see the boot logo (peguin) in the lcd display and
> all "printk" output.
> 
> But I am unable to see the busybox in the lcd display.
> 
> busybox prompt and all output from busybox is going to the serial port.
> 
> Like  if I do ls, then I see the output of "ls" in my serial port
> (teraterm/hyper terminal).
> 
> How I can see busybox prompt and all output to my lcd display.
> 
> 
> I use console=tty0 in the bootargs.
> 
> any advice?
> 
> 
> Regards,
> -SG
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

