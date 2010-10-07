From: Tony Lindgren <tony@atomide.com>
Subject: Re: NOTE: hwmod changes merged to linux-omap master for testing
Date: Wed, 6 Oct 2010 17:04:19 -0700
Message-ID: <20101007000418.GE4859@atomide.com>
References: <20101002004821.GN3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <AANLkTim_x=AykoGMZkHTPpXkX=6k+QA04VetqY56c57G@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC09@dbde02.ent.ti.com>
 <AANLkTikMmqe0ozTLY5qc8O3k=_vLAa1n2PB7cYsrEuR7@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC13@dbde02.ent.ti.com>
 <AANLkTikTmBxjRfy-0Ks_iJk2O7+jMYoKk6WChyO21wDW@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC47@dbde02.ent.ti.com>
 <AANLkTik9XBxRiV-r=tWoegiYtzmXKUDy9SzfBKjGz3Cz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62395 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab0JGAEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 20:04:21 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik9XBxRiV-r=tWoegiYtzmXKUDy9SzfBKjGz3Cz@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Ohad Ben-Cohen <ohad@wizery.com> [101004 15:21]:
> On Mon, Oct 4, 2010 at 2:52 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> > Remove nosmp from your bootargs and try.
> 
> Indeed, it doesn't boot.
> 
> wizery.com/ohad/blaze-linux-omap-smp.txt.gz

FYI, posted a fix for this:

http://patchwork.kernel.org/patch/237401/

Regards,

Tony
