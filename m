From: Paul Walmsley <paul@pwsan.com>
Subject: I2C broken on OMAP 2430SDP?
Date: Tue, 1 Dec 2009 09:00:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912010857070.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbZLAQAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 11:00:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: m-sonasath@ti.com


Hi,

just wanted to mention that i2c-omap.c has some problems on the 2430SDP 
with the linux-omap kernel running Linux 2.6.32-rc8, commit 
4355c41a635943d30e9396b95185314343dcb551. This shows up at boot:

bio: create slab <bio-0> at 0
<6>i2c_omap i2c_omap.1: bus 1 rev3.6 at 400 kHz
<6>i2c_omap i2c_omap.2: bus 2 rev3.6 at 2600 kHz
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing gpio IMR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing gpio SIH_CTRL
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing keypad IMR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing keypad SIH_CTRL
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing bci IMR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing madc IMR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing power IMR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing power SIH_CTRL
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing gpio ISR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing gpio ISR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing keypad ISR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing keypad ISR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing bci ISR
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<4>i2c_omap i2c_omap.2: timeout waiting for bus ready
<3>twl4030: err -110 initializing bci ISR
...

This is with omap_2430sdp_defconfig.


- Paul
