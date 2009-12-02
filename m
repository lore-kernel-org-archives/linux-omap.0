From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: I2C broken on OMAP 2430SDP?
Date: Wed, 2 Dec 2009 16:36:26 -0600
Message-ID: <CD8CC2B65FEE304DA95744A5472698F2029E755F76@dlee06.ent.ti.com>
References: <alpine.DEB.2.00.0912010857070.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbZLBWgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:23 -0500
In-Reply-To: <alpine.DEB.2.00.0912010857070.13408@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Hello Paul!

Thank you for pointing this out.

I think we are missing a patch here which was actually sent for up-stream but did not make through as I don't see it on my latest master branch.

http://patchwork.kernel.org/patch/49514/


Can you please apply this and see if it helps, I don't have any 2430SDP platform to test.

Regards
Moiz Sonasath
 

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, December 01, 2009 10:01 AM
> To: linux-omap@vger.kernel.org
> Cc: Sonasath, Moiz
> Subject: I2C broken on OMAP 2430SDP?
> 
> 
> Hi,
> 
> just wanted to mention that i2c-omap.c has some problems on the 2430SDP
> with the linux-omap kernel running Linux 2.6.32-rc8, commit
> 4355c41a635943d30e9396b95185314343dcb551. This shows up at boot:
> 
> bio: create slab <bio-0> at 0
> <6>i2c_omap i2c_omap.1: bus 1 rev3.6 at 400 kHz
> <6>i2c_omap i2c_omap.2: bus 2 rev3.6 at 2600 kHz
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing gpio IMR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing gpio SIH_CTRL
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing keypad IMR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing keypad SIH_CTRL
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing bci IMR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing madc IMR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing power IMR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing power SIH_CTRL
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing gpio ISR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing gpio ISR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing keypad ISR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing keypad ISR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing bci ISR
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
> <3>twl4030: err -110 initializing bci ISR
> ...
> 
> This is with omap_2430sdp_defconfig.
> 
> 
> - Paul
