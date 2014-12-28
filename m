From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2] ARM: dts: cm-t3x: add NAND support
Date: Sun, 28 Dec 2014 16:54:11 +0200
Message-ID: <54A01993.3060002@compulab.co.il>
References: <54A00BD6.8010507@compulab.co.il> <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36520 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbaL1OyT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Dec 2014 09:54:19 -0500
In-Reply-To: <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?windows-1252?Q?Beno=EEt_?= =?windows-1252?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/28/14 16:30, Dmitry Lifshitz wrote:
> CM-T3517, CM-T3530 and CM-T3730 features NAND storage chip connected to
> GPMC bus.
> 
> Add GPMC DT entry into the root DT file omap3-cm-t3x.dtsi, common for
> all three modules.
> 
> NAND timings are calculated to be safe for CM-T3x devices as it works
> now in non DT boot (in this case the timings are updated by U-Boot).
> 
> Update GPMC ranges in boards DT files to include all connected devices.
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
