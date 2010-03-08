From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 04/10] OMAP clock: Add
 uart4_ick/fck definitions for 3630
Date: Mon, 8 Mar 2010 20:28:44 +0200
Message-ID: <20100308182843.GE6630@gandalf>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
 <1268069332-14082-5-git-send-email-saaguirre@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57763 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab0CHS22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:28:28 -0500
Content-Disposition: inline
In-Reply-To: <1268069332-14082-5-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On Mon, Mar 08, 2010 at 11:28:46AM -0600, Sergio Aguirre wrote:
> @@ -3420,6 +3440,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
>  	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
>  	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
> +	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
>  	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
> @@ -3443,6 +3464,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
>  	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
>  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
> +	CLK(NULL,	"uart4_ick",	&uart4_ick,	CK_36XX),

are the uart clocks shared ? Why not defining the devname here if
they're not ? We would loop less to find the clock that way.

-- 
balbi
