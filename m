From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Regulator: Registering USB internal LDOs for
 TWL4030
Date: Mon, 11 Jan 2010 10:56:12 +0000
Message-ID: <20100111105612.GA20717@rakim.wolfsonmicro.main>
References: <1263201918-8185-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40064 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752332Ab0AKK4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 05:56:14 -0500
Content-Disposition: inline
In-Reply-To: <1263201918-8185-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Mon, Jan 11, 2010 at 02:55:18PM +0530, Anuj Aggarwal wrote:
> Adding member variables for USB internal LDOs in twl4030_platform_data
> and registering them in twl-core.c if the variables are populated
> from board-evm file.

> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
