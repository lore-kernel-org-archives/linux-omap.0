From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv13 27/40] ARM: dts: omap3 clock data
Date: Tue, 21 Jan 2014 09:42:18 +0200
Message-ID: <52DE24DA.8050104@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com> <1389276051-1326-28-git-send-email-t-kristo@ti.com> <20140120180053.GA25920@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59472 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaAUHmv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 02:42:51 -0500
In-Reply-To: <20140120180053.GA25920@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 01/20/2014 08:00 PM, Sebastian Reichel wrote:
> Hi,
>
> I just found some time to update my SSI driver adding DT clock
> support. It works, but I wonder if the alias of the ssi clocks
> can be changed to something like the following:
>
> /* omap3430es1-clocks.dtsi */
> ssi_ick: ssi_ick_3430es1 {};
> ssi_ssr_fck: ssi_ssr_fck_3430es1 {};
> ssi_sst_fck: ssi_sst_fck_3430es1 {};
>
> /* omap36xx-omap3430es2plus-clocks.dtsi */
> ssi_ick: ssi_ick_3430es2 {};
> ssi_ssr_fck: ssi_ssr_fck_3430es2 {};
> ssi_sst_fck: ssi_sst_fck_3430es2 {};
>
> With this change I can reference the ssi clocks in omap3.dtsi
> instead of creating files for omap3430es1 and omap3430es2+.

Yea looks like a valid change to me. Feel free to send a patch for it.

-Tero

