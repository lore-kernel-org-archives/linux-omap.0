From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/4] ARM: OMPA4: Basic boot patch series based on linux-omap
Date: Wed, 20 May 2009 18:11:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4A84356@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49912 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643AbZETMlv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 08:41:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,
I have rebased this series on top of the 'for-next' branch (2.6.30-rc6) in linux-omap tree. Additionally the series is reorganized as you suggested.

As discussed earlier, there is a dependency on arch/arm/tools/mach-types(dated:18/04/2009).

	[PATCH 1/4] ARM: OMAP4: Add minimal support for omap4
	[PATCH 2/4] ARM: OMAP4: Clock stubs since clock management framework not in
	[PATCH 3/4] ARM: OMAP4: Add support for 4430 SDP
	[PATCH 4/4] ARM: OMAP4: Add defconfig for 4430 SDP

Regards,
Santosh
