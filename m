From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v5 3/3] mtd: devices: elm: Low power transition support
Date: Mon, 1 Jul 2013 07:35:57 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E0CEC@DBDE04.ent.ti.com>
References: <1371494799-11876-1-git-send-email-pekon@ti.com>
 <1371494799-11876-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35059 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709Ab3GAHga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 03:36:30 -0400
In-Reply-To: <1371494799-11876-4-git-send-email-pekon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Artem Bityutskiy (artem.bityutskiy@linux.intel.com)" <artem.bityutskiy@linux.intel.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "khilman@linaro.org" <khilman@linaro.org>, "Philip, Avinash" <avinashphilip@ti.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 
> From: avinash philip <avinashphilip@ti.com>
> 
> ELM is used for locating bit-flip errors in when using BCH ECC scheme.
> This patch adds suspend/resume support for leaf level ELM driver,
> And also provides ELM register context save & restore support, so that
> configurations are preserved across hardware power-off/on transitions.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---

Hi Artem,

In following series [Patch 1/3] and [Patch 2/3] were picked up by  Tony (for GPMC). But this last one is awaits your approval, as it touches ELM driver in driver/*mtd*/devices. If everything clean then please pull this one for v3.11 merge.

Also, request you to please look into 
"[PATCH v3 0/4] mtd:nand:omap2: clean-up of supported ECC schemes" series, if it can be taken for 3.11 merge, as lot of further omap2-nand driver enhancements are based on this series.

Thanks ...
with regards, pekon
