From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Load triton2 scripts.
Date: Mon, 21 Jul 2008 20:32:24 +0300
Message-ID: <20080721173222.GB4738@frodo>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com> <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com> <1216656125-5800-3-git-send-email-peter.de-schrijver@nokia.com> <1216656125-5800-4-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57723 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYGURcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 13:32:39 -0400
Content-Disposition: inline
In-Reply-To: <1216656125-5800-4-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jul 21, 2008 at 07:02:05PM +0300, Peter 'p2' De Schrijver wrote:
> +/*
> +*	Power Bus Message Format
> +*
> +*	Broadcast Message (16 Bits)
> +*	DEV_GRP[15:13] MT[12]  RES_GRP[11:9]  RES_TYPE2[8:7] RES_TYPE[6:4]
> +*	RES_STATE[3:0]
> +*
> +*	Singular Message (16 Bits)
> +*	DEV_GRP[15:13] MT[12]  RES_ID[11:4]  RES_STATE[3:0]
> +*
> +*/

This comment should follow the coding style:

/*
 * Power Bus Message Format
 *
 * Broadcast Message (16 Bits)
 * DEV_GRP[15:13] MT[12]  RES_GRP[11:9]  RES_TYPE2[8:7] RES_TYPE[6:4]
 * RES_STATE[3:0]
 *
 * Singular Message (16 Bits)
 * DEV_GRP[15:13] MT[12]  RES_ID[11:4]  RES_STATE[3:0]
 */

> +struct triton_ins {
> +	u16 pmb_message;
> +	u8 delay;
> +};
> +
> +

extra line

> +#define CONFIG_DISABLE_HFCLK	1
> +
> +#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
> +
> +struct triton_ins sleep_on_seq[] __initdata = {
> +	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4},

could you add spaces here??
	{ MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4 },

-- 
balbi
