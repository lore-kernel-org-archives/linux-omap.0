From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V3 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
Date: Mon, 5 Nov 2012 18:45:50 +0100
Message-ID: <5097FB4E.4090609@ti.com>
References: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57332 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab2KERqH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 12:46:07 -0500
In-Reply-To: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org

Hi Lokesh,

On 11/05/2012 01:52 PM, Lokesh Vutla wrote:
> This patch series adds Device tree data for the EMIF 
> sdram controllers in OMAP5 and LPDDR2 memory devices 
> in OMAP5-evm board.
> 
> Testing:
> - Boot tested on OMAP5430 evm.
> - Built EMIF as a module.
> 
> Changes from v2:
> * Rebased on top of
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts
> * Addressed few other comments from Benoit.

Thanks for this quick update.
I've just applied your series in my for_3.8/dts_part2 branch.

Regards,
Benoit

