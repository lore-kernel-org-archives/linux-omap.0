From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: sbc-t54: add support for sbc-t54 with
 cm-t54
Date: Mon, 5 May 2014 15:31:18 -0700
Message-ID: <20140505223118.GJ25949@atomide.com>
References: <1396962531-27729-1-git-send-email-lifshitz@compulab.co.il>
 <1398685305-29840-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19951 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000AbaEEWbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 18:31:23 -0400
Content-Disposition: inline
In-Reply-To: <1398685305-29840-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

* Dmitry Lifshitz <lifshitz@compulab.co.il> [140428 04:43]:
> Add support for CompuLab CM-T54 CoM and SBC-T54 board:
>     
>     http://compulab.co.il/products/computer-on-modules/cm-t54/
>     http://compulab.co.il/products/sbcs/sbc-t54/
>     
> SBC-T54 is a single board computer based on OMAP5432 CPU.
> It is implemented with a CM-T54 CoM providing most of the functions,
> and SB-T54 carrier board providing connectors and several additional
> functions.
> 
> Changes from V1:
> 
> * Used OMAP5_CORE_IOPAD macros for pimnux settings
> * Added CD and WP support for SD/MMC card on SB-T54
> * Platform quirk for deasserting PDN and RST GPIOs of WiFi chip replaced by
>   appropriate regulators in DT.

Thanks applying into omap-for-v3.16/dt.

Tony
