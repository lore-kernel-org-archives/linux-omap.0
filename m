From: Paul Walmsley <paul@pwsan.com>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Mon, 20 Apr 2009 11:47:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904201141380.13457@utopia.booyaka.com>
References: <873ac7ko2n.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34770 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZDTRrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 13:47:07 -0400
In-Reply-To: <873ac7ko2n.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi Kalle,

On Fri, 17 Apr 2009, Kalle Valo wrote:

> In file included from arch/arm/mach-omap2/clock24xx.c:46:
> arch/arm/mach-omap2/clock24xx.h:1801: error: 'secure_32k_ck' undeclared here (not in a function)
>
> Any hints?

This is a bug in the version of fa9ef57a1efdd4e7c41a42db71d99b9b69e9b356 I 
pushed.  The new clock definition in clock24xx.h for "secure_32k_fck" 
should be for "secure_32k_ck".  Just talked with Tony about this; he's 
going to re-pull a fixed version of that patch today.

Thanks for the find,

- Paul
