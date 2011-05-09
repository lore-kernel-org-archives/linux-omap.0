From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (encore) support.
Date: Mon, 9 May 2011 21:28:08 +0100
Message-ID: <20110509202807.GA19492@sirena.org.uk>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru> <1304891407-29364-2-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33843 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab1EIU2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 16:28:10 -0400
Content-Disposition: inline
In-Reply-To: <1304891407-29364-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, May 08, 2011 at 05:50:06PM -0400, green@linuxhacker.ru wrote:

> +	/*
> +	 * link regulators to MMC adapters ... we "know" the
> +	 * regulators will be set up only *after* we return.
> +	 */
> +	encore_vmmc1_supply.dev = mmc[1].dev;

Just specify dev_name in the supply rather than doing this.
