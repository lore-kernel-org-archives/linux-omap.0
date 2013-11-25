From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP4: hwmod: add hwmod data for DES IP
Date: Mon, 25 Nov 2013 14:11:11 -0800
Message-ID: <20131125221111.GU10023@atomide.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
 <1385415876-12387-6-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60248 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3KYWLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 17:11:16 -0500
Content-Disposition: inline
In-Reply-To: <1385415876-12387-6-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

* Joel Fernandes <joelf@ti.com> [131125 13:45]:
> +
> +static struct omap_hwmod_addr_space omap4_des_addrs[] = {
> +	{
> +		.pa_start	= 0x480A4000,
> +		.pa_end		= 0x481A4000,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +	{ }
> +};

Let's not add new address space entries. The address
space should be already coming from device tree.

Regards,

Tony
