From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
	from DT
Date: Sat, 3 Aug 2013 19:31:43 +0100
Message-ID: <20130803183143.GE23053@n2100.arm.linux.org.uk>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <1375460751-23676-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40114 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab3HCSbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Aug 2013 14:31:55 -0400
Content-Disposition: inline
In-Reply-To: <1375460751-23676-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, Aug 02, 2013 at 07:25:20PM +0300, Tero Kristo wrote:
> +
> +	if (cl)
> +		return cl;
> +
> +	/* If clock was not found, attempt to look-up from DT */
> +	node = of_find_node_by_name(NULL, con_id);

This is utterly broken if you're looking up purely by a connection ID.
Please, go back and read clk_get()'s documentation in linux/clk.h.
It's spelt out very plainly there.

NAK.
