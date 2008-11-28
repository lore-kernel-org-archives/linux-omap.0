From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: PATCH[0/3] - Framework for TPS device drivers on PR785 power
Date: Fri, 28 Nov 2008 11:01:36 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904EB65@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbYK1Fbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 00:31:47 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAS5Vdin022225
	for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 23:31:46 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAS5VdkU021002
	for <linux-omap@vger.kernel.org>; Fri, 28 Nov 2008 11:01:39 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


PR785 boards is a replacement for the Triton Power boards for OMAP3 
EVM. It has a TPS62352 and TPS62353 device onboard for controlling the 
CORE and MPU voltage for OMAP3 EVM. This patch provides the support 
framework for PR785 boards. This patch series also helps in building 
code without TWL4030 and introduces the base functionality for 
TPS6235x based board.
 
More patches will follow that will allow complete programming support 
for TPS6235x devices for PR785 boards.
 
The board-omap3evm.c contains the I2C devices to be supported.
CONFIG_PR785 is configuration used for the PR784 boards.
 
Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>

