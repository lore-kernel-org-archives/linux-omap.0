From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [TRIVIAL PATCH] Fix compilation of
 arch/arm/mach-omap1/mailbox.c
Date: Mon, 15 Jun 2009 12:15:31 +0300 (EEST)
Message-ID: <20090615.121531.123974522.Hiroshi.DOYU@nokia.com>
References: <20090612235059.GJ6704@earth.li>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23205 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZFOJQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 05:16:00 -0400
In-Reply-To: <20090612235059.GJ6704@earth.li>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, noodles@earth.li

From: ext Jonathan McDowell <noodles@earth.li>
Subject: [TRIVIAL PATCH] Fix compilation of arch/arm/mach-omap1/mailbox.c
Date: Sat, 13 Jun 2009 01:50:59 +0200

> This fixes the positioning of " in MODULE_AUTHOR, which is currently
> causing a build failure on latest git with CONFIG_OMAP_MBOX_FWK=m; the
> original breakage appears to date from the end of last year in
> a5abbbe52b7e89a7633319c5417bd4331f7ac8ed
> 

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> -----
> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index 0af4d6c..6810b4a 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -203,5 +203,5 @@ module_exit(omap1_mbox_exit);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
> -MODULE_AUTHOR("Hiroshi DOYU" <Hiroshi.DOYU@nokia.com>);
> +MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
>  MODULE_ALIAS("platform:omap1-mailbox");
> -----
> 
> J.
> 
> -- 
> ] http://www.earth.li/~noodles/ []     "Making the impossible very     [
> ]  PGP/GPG Key @ the.earth.li   []     difficult" -- The OpenGALEN     [
> ] via keyserver, web or email.  []              website.               [
> ] RSA: 4096/2DA8B985            []                                     [
