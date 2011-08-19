From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 3/3] TI814X: Create board support and enable build for
 TI8148 EVM
Date: Fri, 19 Aug 2011 09:57:18 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABD26D8D@dbde02.ent.ti.com>
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
 <20110815151509.GT12348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42164 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab1HSE12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 00:27:28 -0400
In-Reply-To: <20110815151509.GT12348@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Tony Lindgren wrote on Monday, August 15, 2011 8:45 PM:

> * Hemant Pedanekar <hemantp@ti.com> [110804 20:39]:
>> This patch adds minimal support and build configuration for TI8148 EVM.
>> Also adds support for low level debugging on UART1 console on the EVM. ...
> 
> 
>> +MACHINE_START(TI8148EVM, "ti8148evm")
>> +	/* Maintainer: Texas Instruments */
>> +	.boot_params	= 0x80000100,
>> +	.map_io		= ti8148_evm_map_io,
>> +	.init_early	= ti8148_init_early,
>> +	.init_irq	= ti81xx_init_irq,
>> +	.timer		= &omap3_timer,
>> +	.init_machine	= ti8148_evm_init,
>> +MACHINE_END
> 
> Please just combine this with board-ti8168evm.c by adding the MACHINE_START
> there. It seems the files are identical otherwise?
> 

Tony,
There will be more additions in respective board files such as I2C I/O expander
data, mux handling depending upon the EVM (8168/8148), on board peripherals etc
When these board files would deviate.

What do you suggest to handle such?

Thanks.
   Hemant