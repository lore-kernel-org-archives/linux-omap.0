From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: I2C broken on OMAP 2430SDP?
Date: Thu, 3 Dec 2009 23:39:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54C@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0912010857070.13408@utopia.booyaka.com>
 <CD8CC2B65FEE304DA95744A5472698F2029E755F76@dlee06.ent.ti.com>
 <alpine.DEB.2.00.0912030559500.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44885 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZLCSJR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 13:09:17 -0500
In-Reply-To: <alpine.DEB.2.00.0912030559500.13408@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>


>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Thursday, December 03, 2009 7:01 AM
>To: Sonasath, Moiz
>Cc: linux-omap@vger.kernel.org; Pandita, Vikram; G, Manjunath Kondaiah
>Subject: RE: I2C broken on OMAP 2430SDP?
>
>Hello Moiz,
>
>On Wed, 2 Dec 2009, Sonasath, Moiz wrote:
>
>> Hello Paul!
<snip>
>bio: create slab <bio-0> at 0
><6>i2c_omap i2c_omap.1: bus 1 rev3.6 at 400 kHz
><6>i2c_omap i2c_omap.2: bus 2 rev3.6 at 2600 kHz

By any chance is this related to running i2c at slower clock speed? 
commit 6b61a83b31744d143b0e7bc92f463d831319eabc
    The maximum I2C speed depends on the system clock for GAIA:
    2.2 MHz (sys-clk = 19.2 MHz)
    2.4 MHz (sys-clk = 26 MHz)
    2.9 MHz (sys-clk = 38.4 MHz)


><4>i2c_omap i2c_omap.2: timeout waiting for bus ready
><4>i2c_omap i2c_omap.2: timeout waiting for bus ready
><4>i2c_omap i2c_omap.2: timeout waiting for bus ready
><3>twl4030: clock init err [-110]
><4>i2c_omap i2c_omap.2: timeout waiting for bus ready
><3>twl4030: err -110 initializing gpio IMR
><4>i2c_omap i2c_omap.2: timeout waiting for bus ready
><3>twl4030: err -110 initializing gpio SIH_CTRL
