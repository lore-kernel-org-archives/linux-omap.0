From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to am335x-bone.dts
Date: Thu, 23 Aug 2012 16:13:48 +0200
Message-ID: <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com> <1345547850-29761-5-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38544 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab2HWONy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Aug 2012 10:13:54 -0400
Received: by weyx8 with SMTP id x8so427018wey.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 07:13:52 -0700 (PDT)
In-Reply-To: <1345547850-29761-5-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com


Op 21 aug. 2012, om 13:17 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:

> Add tps65217 regulator device tree data to AM335x-Bone by adding
> regulator consumers with tightened constraints and regulator-name.
> TPS65217 regulator handle can be obtained by using this regulator
> name.
> 
> This patch also add I2C node with I2C frequency and tps65217 PMIC
> I2C slave address.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

I tried this and the kernel immediately crashes on my beaglebone. Could you upload the complete git tree and .config you used to test this to somewhere public please?


