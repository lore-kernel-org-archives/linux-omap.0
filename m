From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: USB-webcam support
Date: Tue, 12 Aug 2008 16:45:27 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208C15FD8@dbde02.ent.ti.com>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbYHLLPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 07:15:41 -0400
In-Reply-To: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Arun,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of arun c
> Sent: Tuesday, August 12, 2008 4:02 PM
> To: linux-omap@vger.kernel.org
> Subject: USB-webcam support
> 
> Hi All,
> 
> If I have a USB camera with good Linux support, can I connect it
> to omap3evm(or any omap2) and make it functional?
> 
Yes you can, I have tried Logitech LZ708BC on Beagle board and it works good at 160x120 resolution.

You just need UVC driver, which I think is part of latest kernel.

Regards,
Khasim
http://khasim.blogspot.com

