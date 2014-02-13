From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 0/5] add parallel NAND support for TI's new OMAPx and
 AMxx platforms
Date: Thu, 13 Feb 2014 04:27:30 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA6FE42@DBDE04.ent.ti.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48951 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbaBME1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2014 23:27:40 -0500
In-Reply-To: <1391606914-9947-1-git-send-email-pekon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "Benoit Cousson (benoit.cousson@linaro.org)" <benoit.cousson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Benoit, Tony,
 
>From: Gupta, Pekon
>
>This patch-set adds and updates parallel NAND support on following TI platforms
> - AM335x (am335x-evm)
> - DRA7xx (dra7-evm
> - AM43xx (am43X-epos-evm)
>
>In addition, following OMAP2+/GPMC patch is also added in this series as
>it add checks DRA7xx and AM43xxx platforms for non-DT kernels.
>	ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms
>
Please let me know, if this patch-set is in acceptable state,
Or should I rebase it against any specific branch at your side ?


with regards, pekon
