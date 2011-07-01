From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: Keyboard: Mux changes in the board file
Date: Fri, 1 Jul 2011 00:48:25 -0700
Message-ID: <20110701074824.GH23145@atomide.com>
References: <1308831317-17092-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20967 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755094Ab1GAHs1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:48:27 -0400
Content-Disposition: inline
In-Reply-To: <1308831317-17092-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org

* Shubhrajyoti D <shubhrajyoti@ti.com> [110623 05:10]:
> The mux settings for keypad  are done for omap4430sdp in
> board file.

Applying into devel-board branch.

> +static struct omap_board_data keypad_data = {
> +	.id	    = 1,
> +	.pads	 = keypad_pads,
> +	.pads_cnt       = ARRAY_SIZE(keypad_pads),
> +};

Aligned this struct better.

Tony
