From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] Common mechanism to identify Si revision
Date: Thu, 10 Sep 2009 03:29:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0909100325360.3024@utopia.booyaka.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44728 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbZIJJ3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 05:29:17 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Sanjeev,

On Thu, 3 Sep 2009, Premi, Sanjeev wrote:

> Here, I am proposing a common mechanism to identify the si revision; that focuses
> on the revision bits alone. (See code below)
> 
> The usage would then be (example):
> 
>    if (omap_rev() > OMAP3430_REV_ES1_0)
> 
> To
> 
>    if (cpu_is_omap34xx() && OMAP_REV_GT(OMAP_ES_1_0)

For use in structures like clock34xx.h and powerdomains34xx.h, would you 
propose that we use two different fields then - one for OMAP type, the 
other for revision restrictions?  Or a different scheme?


- Paul
