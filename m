From: shankarGanesh <shankarganeshk@gmail.com>
Subject: Re: X-loader / U-Boot query
Date: Thu, 08 Oct 2009 19:22:10 +0530
Message-ID: <4ACDEE8A.2010807@gmail.com>
References: <4ACDE1DF.1010303@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:38664 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222AbZJHNwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:52:55 -0400
Received: by fxm27 with SMTP id 27so5529340fxm.17
        for <linux-omap@vger.kernel.org>; Thu, 08 Oct 2009 06:52:18 -0700 (PDT)
In-Reply-To: <4ACDE1DF.1010303@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> 
> The problem I have now is that it's only seeing 1/2 (256MB)
> of the available DRAM.

Please refer sdrc_init() in  u-boot/board/omap3530beagle/mem.c . 
SDRC_MCFG register has definition for SIZE and CS settings.
Refer [1] for details about SDRC configurations.


[1]http://focus.ti.com/pdfs/wtbu/SWPU114Q_PrelimFinal_EPDF_03_05_2009.pdf

Regards,
Shankar

> 
> * Does anyone know how to get it to see all 512MB?
> * Is there a better place to ask/discuss these questions?
>   A cursory look around did not point to anything fresh (most
>   of the web pages & Wikis I looked are are _years_ old)
> 
> Thanks for any help/pointers
> 

