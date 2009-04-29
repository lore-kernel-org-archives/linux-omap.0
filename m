From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain()
 signature
Date: Wed, 29 Apr 2009 22:08:04 +0300
Message-ID: <20090429220804.2d130ceb.jhnikula@gmail.com>
References: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:39384 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZD2THD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 15:07:03 -0400
Received: by ewy24 with SMTP id 24so1453109ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 12:07:02 -0700 (PDT)
In-Reply-To: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 29 Apr 2009 17:39:16 +0530
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> Original OMAP DMA chaining design has chain_id as one of the callback
> parameters. The below patch broke the desing.
> http://git.omapzoom.org/?p=repo/omapkernel.git;a=commitdiff;h=538528de0cb256f65716ab2e9613d9e920f97fe2
> Now callback returns logical channel number and not chain_id. 
> Hence the signature of the omap_request_dma_chain() functions needs
> to be corrected to avoid any confusion.
> 
> More details are on this email thread :
> http://marc.info/?l=linux-omap&m=122961071931459&w=2
> 
Thanks! And this thread where I promised to send a patch but never done
it...

http://marc.info/?l=linux-omap&m=122770291205164&w=2

Two comments:
"Now callback returns logical channel number and not chain_id. "
You mean callback gets lch instead of chain_id as an argument?

Change also kernel-doc function comment for omap_request_dma_chain.
I.e. those comment lines few lines before the function itself.

-- 
Jarkko
