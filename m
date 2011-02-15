From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v7 3/4] TI816X: Create board support and enable build
	for TI816X EVM
Date: Tue, 15 Feb 2011 18:01:39 +0000
Message-ID: <20110215180139.GF11199@n2100.arm.linux.org.uk>
References: <1297791368-32042-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58568 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab1BOSBu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 13:01:50 -0500
Content-Disposition: inline
In-Reply-To: <1297791368-32042-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 11:06:08PM +0530, Hemant Pedanekar wrote:
> +static void __init ti8168_evm_init_irq(void)
> +{
> +	omap_board_config = ti8168_evm_config;
> +	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(NULL, NULL);
> +	omap_init_irq();
> +}

What here can use the new init_early hook in the machine record?
