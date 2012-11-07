From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND] [PATCH 3.6.0- 1/6] ARM/omap1: use
 module_platform_driver macro
Date: Tue, 6 Nov 2012 17:21:53 -0800
Message-ID: <20121107012153.GA6801@atomide.com>
References: <1350025868-30482-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16159 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753314Ab2KGBWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 20:22:02 -0500
Content-Disposition: inline
In-Reply-To: <1350025868-30482-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: paul@pwsan.com, rnayak@ti.com, Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

* Srinivas KANDAGATLA <srinivas.kandagatla@st.com> [121012 00:14]:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch removes some code duplication by using
> module_platform_driver.

Sorry for delay on these, we're moving the mailbox code to
live under drivers, so these may need to wait a little bit.

Regards,

Tony
 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  arch/arm/mach-omap1/mailbox.c |   14 +-------------
>  1 files changed, 1 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index e962926..45c8719 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -179,19 +179,7 @@ static struct platform_driver omap1_mbox_driver = {
>  		.name	= "omap-mailbox",
>  	},
>  };
> -
> -static int __init omap1_mbox_init(void)
> -{
> -	return platform_driver_register(&omap1_mbox_driver);
> -}
> -
> -static void __exit omap1_mbox_exit(void)
> -{
> -	platform_driver_unregister(&omap1_mbox_driver);
> -}
> -
> -module_init(omap1_mbox_init);
> -module_exit(omap1_mbox_exit);
> +module_platform_driver(omap1_mbox_driver);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
> -- 
> 1.7.0.4
> 
