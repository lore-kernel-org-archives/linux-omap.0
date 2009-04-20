From: Paul Walmsley <paul@pwsan.com>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Mon, 20 Apr 2009 11:56:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904201155540.13457@utopia.booyaka.com>
References: <873ac7ko2n.fsf@litku.valot.fi> <alpine.DEB.2.00.0904201141380.13457@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbZDTR42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 13:56:28 -0400
In-Reply-To: <alpine.DEB.2.00.0904201141380.13457@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Mon, 20 Apr 2009, Paul Walmsley wrote:

> On Fri, 17 Apr 2009, Kalle Valo wrote:
> 
> > In file included from arch/arm/mach-omap2/clock24xx.c:46:
> > arch/arm/mach-omap2/clock24xx.h:1801: error: 'secure_32k_ck' undeclared here (not in a function)
> >
> > Any hints?
> 
> This is a bug in the version of fa9ef57a1efdd4e7c41a42db71d99b9b69e9b356 I 
> pushed.  The new clock definition in clock24xx.h for "secure_32k_fck" 
> should be for "secure_32k_ck".  Just talked with Tony about this; he's 
> going to re-pull a fixed version of that patch today.

Here's the patch BTW:

- Paul


Index: linux-omap-2.6/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock24xx.h	2009-04-20 10:42:21.000000000 -0700
+++ linux-omap-2.6/arch/arm/mach-omap2/clock24xx.h	2009-04-20 10:46:09.000000000 -0700
@@ -625,8 +625,8 @@ static struct clk func_32k_ck = {
 	.clkdm_name	= "wkup_clkdm",
 };
 
-static struct clk secure_32k_fck = {
-	.name		= "secure_32k_fck",
+static struct clk secure_32k_ck = {
+	.name		= "secure_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
 	.flags		= RATE_FIXED,
