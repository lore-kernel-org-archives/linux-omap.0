From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Thu, 23 Oct 2008 15:16:32 -0700
Message-ID: <200810231516.32947.david-b@pacbell.net>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com> <a46a26fd0810221523y4a947442p6eb060192603b8f1@mail.gmail.com> <a46a26fd0810231451n2095b03btc832c2a8b70d2749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:32509 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751269AbYJWWQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 18:16:35 -0400
In-Reply-To: <a46a26fd0810231451n2095b03btc832c2a8b70d2749@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 23 October 2008, Juha Kuikka wrote:
> How does this look?
> 
> Subject: [PATCH] OMAP2 NAND: Change __raw_readsl() to __raw_readsw()

Looks fine.  Although I'm still wondering what happened to that
patch teaching it about the prefetch engine ... it'd be nice to
maximize throughput.

(And it's too bad we can't confirm it's safe that raw_readsl is
actually safe without the FIFO and prefetch being enabled...)

- Dave
