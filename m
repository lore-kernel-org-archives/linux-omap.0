From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v1 0/4] mtd: nand: omap: add support for BCH16_ECC
Date: Fri, 02 Aug 2013 18:56:54 +0300
Message-ID: <1375459014.14869.351.camel@sauron.fi.intel.com>
References: <1374090726-9393-1-git-send-email-pekon@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20089 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab3HBPvm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 11:51:42 -0400
In-Reply-To: <1374090726-9393-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org

On Thu, 2013-07-18 at 01:22 +0530, Pekon Gupta wrote:
> This patch series add support of BCH16_ECC scheme.
> As BCH16_ECC scheme generates 26bytes of ECC syndrome per 512B data,
> hence this scheme is usable only for NAND devices having 4K or above
> page-size, as their OOB/spare area has enough space to accomodate ECC.
> 
> This patch series is applicable over an above following series:
> [1] [Patch] mtd:nand:omap2: clean-up of supported ECC schemes 
>  http://lists.infradead.org/pipermail/linux-mtd/2013-July/047530.html
> [2] [Patch] optimize and clean-up of OMAP NAND and ELM driver
>  http://lists.infradead.org/pipermail/linux-mtd/2013-July/047538.html
> 
> Also this BCH16_ECC patch series is sparsely tested, due to limited
> availability of boards with 4K/224NAND, so request the users to test
> the mentioned series, and provide Tested-by.

I wonder if anyone in the list could help reviewing this?

-- 
Best Regards,
Artem Bityutskiy

