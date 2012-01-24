From: "Paul Chiha" <paul.chiha@greyinnovation.com>
Subject: RE: Help enabling OMAP3/TPS65950 vibration motor
Date: Tue, 24 Jan 2012 16:33:58 +1100
Message-ID: <51A4F524D105AA4C93787F33E2C90E6201026625@greysvr02.GreyInnovation.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eth1683.vic.adsl.internode.on.net ([150.101.217.146]:7953 "EHLO
	greyinnovation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751393Ab2AXFeG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 00:34:06 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Mon, 23 Jan 2012 5:16 PM, Paul Chiha wrote:
> Hi,
> 
> I'm using the DM37x EVM and need to trigger the vibra ports on the
TPS65950.
> It appears that I just need to define INPUT_TWL4030_VIBRA in the
config.
> After doing this, I see that the twl4030-vibra platform driver is
registered, but the
> twl4030_vibra_probe() function is never called.
> Is there something I need to do to the board or to board-omap3evm.c so
that the
> device is available and probing can happen?
> 
> Thanks,
> Paul

Actually, after a bit of debugging, I've found the cause and solution.

The vibra device registration is skipped in twl4030_codec_probe()
because the vibra field of omap3evm_codec_data is missing from
board-omap3evm.c.

Adding the initialisation of this field to something appropriate fixes
the problem.

Paul
