From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [Query] Garbled characters on gtkterm
Date: Tue, 21 Sep 2010 14:50:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032953A883@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB032953A021@dbde02.ent.ti.com>
 <20100917183400.GH29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46044 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab0IUJUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 05:20:31 -0400
In-Reply-To: <20100917183400.GH29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 
> I'm not seeing these, just booted my n800 last night with the cbus
> patches from Felipe. I believe all I did was yes "" | ARCH=arm make
> oldconfig
> on the n8x0_defconfig that we still have around.
> 
> I've seen things like that with some USB serial dongles earlier,
> I believe that the pl2303 based one worked, and then the ftdi
> driver one produced garbage. AFAIK, this was related to some
> problem with the serial port level shifter, I think this was
> with n810.

It is working fine now.
I have just changed from Linux gtkterm to Windows TeraTerm.

--tarun
