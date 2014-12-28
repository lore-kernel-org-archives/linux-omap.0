From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: dts: cm-t3x: add NAND support
Date: Sun, 28 Dec 2014 15:55:34 +0200
Message-ID: <54A00BD6.8010507@compulab.co.il>
References: <1419772503-11671-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:56785 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbaL1Nzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Dec 2014 08:55:42 -0500
In-Reply-To: <1419772503-11671-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?windows-1252?Q?Beno=EEt_?= =?windows-1252?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dima,

On 12/28/14 15:15, Dmitry Lifshitz wrote:
> Add NAND support
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> ---
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   58 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-sbc-t3517.dts |    4 ++
>  arch/arm/boot/dts/omap3-sbc-t3530.dts |   10 ++----
>  arch/arm/boot/dts/omap3-sbc-t3730.dts |    5 ++-
>  4 files changed, 68 insertions(+), 9 deletions(-)

It seems that you have missed the omap3-cm-t3x30.dtsi.
If after this patch you build omap3-cm-t3530.dts or omap3-cm-t3730.dts,
it will not have NAND, while they should get it as well.

-- 
Regards,
Igor.
