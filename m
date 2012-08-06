From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm/dts: AM33XX: Set the default status of module to "disabled" state
Date: Mon, 6 Aug 2012 11:46:58 +0000
Message-ID: <201208061146.58753.arnd@arndb.de>
References: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53308 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2HFLrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 07:47:04 -0400
In-Reply-To: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

On Monday 06 August 2012, Vaibhav Hiremath wrote:
> Ideally in common SoC dtsi file we should set all modules
> to "disabled" state and it should get enabled in respective
> EVM/Board dts file as per usage.
> 
> This patch sets default status of all modules to "disabled"
> state in am33xx.dtsi file, and as per board requirement, enabled
> in board dts file (like, bone, evm, etc...).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> CC: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
