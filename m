From: "Paul Chiha" <paul.chiha@greyinnovation.com>
Subject: Help enabling OMAP3/TPS65950 vibration motor
Date: Mon, 23 Jan 2012 17:15:39 +1100
Message-ID: <51A4F524D105AA4C93787F33E2C90E62010264CD@greysvr02.GreyInnovation.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eth1683.vic.adsl.internode.on.net ([150.101.217.146]:3087 "EHLO
	greyinnovation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752025Ab2AWGbB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 01:31:01 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm using the DM37x EVM and need to trigger the vibra ports on the
TPS65950.
It appears that I just need to define INPUT_TWL4030_VIBRA in the config.
After doing this, I see that the twl4030-vibra platform driver is
registered, but the twl4030_vibra_probe() function is never called.
Is there something I need to do to the board or to board-omap3evm.c so
that the device is available and probing can happen?

Thanks,
Paul
