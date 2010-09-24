From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 00/11] omap patches for review for v2.6.37 merge window
Date: Fri, 24 Sep 2010 08:53:37 +0300
Message-ID: <20100924085337.69c99bd8.jhnikula@gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53342 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab0IXFxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 01:53:38 -0400
Received: by ewy23 with SMTP id 23so660220ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 22:53:36 -0700 (PDT)
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, 23 Sep 2010 18:50:38 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi all,
> 
> Here are some omap patches that have not yet been posted to
> linux-arm-kernel for review.
> 
> Jarkko Nikula (4):
>       omap: n8x0: Cleanup i2c1 and menelaus registration
>       omap: n8x0: Register i2c2 and add board info with tlv320aic3xfor N810
>       omap: n8x0: Mux i2s codec port pins for McBSP block
>       omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and docleanups
> 
...
> Subramaniam C.A (1):
>       omap: i2c: Avoid compilation error in case the header is included multiple times
> 
Hmm... I wonder do I have something wrong or in patchwork but it looks
like somehow a line feed gets introduced to subject line of some of
my patches. And it seems to do with my patches only.

Original patch in my mailbox or archive doesn't show it but it is in
patchwork.

http://marc.info/?l=linux-omap&m=128324955316265&w=2
https://patchwork.kernel.org/patch/144841/mbox


-- 
Jarkko
