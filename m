From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: X-loader / U-Boot query
Date: Thu, 08 Oct 2009 18:45:18 +0200
Message-ID: <4ACE171E.7080800@googlemail.com>
References: <4ACDE1DF.1010303@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:26616 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758728AbZJHQsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 12:48:08 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1933158fge.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Oct 2009 09:46:20 -0700 (PDT)
In-Reply-To: <4ACDE1DF.1010303@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gary Thomas wrote:
> I have a new board - OMAP 3530 with 512MB DRAM & NAND
> I've build X-loader and U-Boot for it and it mostly comes
> up.  The sources I used (based on recommendations from the
> BeagleBoard pages) were:
>   http://git.gitorious.org/x-load-omap3/mainline.git
>   git://git.denx.de/u-boot.git
> 
> I had to make a small change to get it to recognize the
> larger NAND FLASH device.
> 
> The problem I have now is that it's only seeing 1/2 (256MB)
> of the available DRAM.
> 
> * Does anyone know how to get it to see all 512MB?

Not exactly on how to see all 512MB. But while we switched U-Boot 
Beagle to support 256MB instead of 128MB we did what is in

http://git.mansr.com/?p=u-boot;a=shortlog;h=refs/heads/old

Maybe the top ~10 commits from Mans there could help you.

> * Is there a better place to ask/discuss these questions?

Yes. U-Boot list. It was already mentioned in this thread.

Cheers

Dirk

