From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 3430: can't find mmc debounce clock
Date: Wed, 10 Sep 2008 06:44:30 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809100641010.20446@utopia.booyaka.com>
References: <57314e840809080618x1f0cd0aen74b1a03351dc8ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56580 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYIJMob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 08:44:31 -0400
In-Reply-To: <57314e840809080618x1f0cd0aen74b1a03351dc8ef7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, 8 Sep 2008, Budhee Jamaich wrote:

> I read that the mmc has 3 clocks: fixed functional clock (MMCi_FCLK),
> interface clock (MMCi_ICLK) and debounce clock (MMCi_32).
> 
> But, when I look in clock34xx.h, I can only see two of those - there
> is the "mmchs_fck" and "mmchs_ick". There is no struct clk for the
> debounce clock. Only when I look in older kernels I can see also the
> "mmchsdb2_fck".
> 
> So where is the debounce clock struct ? (I want to 'get' and 'enable' it...)

The debounce clocks are controlled by gpio[1-6]_fck.  Perhaps we should 
rename them, but that's what the current tree uses.


- Paul
