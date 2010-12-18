From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Sat, 18 Dec 2010 08:27:03 +0000
Message-ID: <20101218082703.GB3047@n2100.arm.linux.org.uk>
References: <20101218030406.10251.73118.stgit@baageli.muru.com> <20101218030521.10251.89993.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47781 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0LRI1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 03:27:13 -0500
Content-Disposition: inline
In-Reply-To: <20101218030521.10251.89993.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Raghuveer Murthy <raghuveer.murthy@ti.com>

On Fri, Dec 17, 2010 at 07:05:21PM -0800, Tony Lindgren wrote:
>  	/* Maintainer: David Anders - Texas Instruments Inc */
>  	.boot_params	= 0x80000100,
>  	.map_io		= omap4_panda_map_io,
> +	.reserve	= omap_reserve,

Please put .reserve before .map_io.
