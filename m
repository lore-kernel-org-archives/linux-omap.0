From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
Date: Mon, 10 Sep 2012 11:55:35 -0700
Message-ID: <20120910185535.GC1303@atomide.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
 <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60802 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757867Ab2IJSzk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 14:55:40 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120908 01:20]:
> 
> Will you able to pick up these couple of wakeupgen fixes from  here or
> do you want me to send you a pull request for 3.6-rc5/6

I can pick them into fixes-noncritical. But if the second one is
a major bug for the -rc series, the patch should be describe what
breaks (regression? oops?).

Regards,

Tony
