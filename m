From: Paul Walmsley <paul@pwsan.com>
Subject: RE: I2C broken on OMAP 2430SDP?
Date: Thu, 3 Dec 2009 06:00:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030559500.13408@utopia.booyaka.com>
References: <alpine.DEB.2.00.0912010857070.13408@utopia.booyaka.com> <CD8CC2B65FEE304DA95744A5472698F2029E755F76@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39834 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZLCNAr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:00:47 -0500
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F2029E755F76@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Hello Moiz,

On Wed, 2 Dec 2009, Sonasath, Moiz wrote:

> Hello Paul!
> 
> Thank you for pointing this out.
> 
> I think we are missing a patch here which was actually sent for up-stream but did not make through as I don't see it on my latest master branch.
> 
> http://patchwork.kernel.org/patch/49514/
> 
> 
> Can you please apply this and see if it helps, I don't have any 2430SDP platform to test.

I tried that patch and it did not help :-(  Same symptoms:

bio: create slab <bio-0> at 0
<6>i2c_omap i2c_omap.1: bus 1 rev3.6 at 400 kHz
<6>i2c_omap i2c_omap.2: bus 2 rev3.6 at 2600 kHz
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: clock init err [-110]
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing gpio IMR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing gpio SIH_CTRL

... etc.


Thanks for the suggestion,

- Paul
