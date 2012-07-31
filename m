From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and
 clk_unprepare
Date: Tue, 31 Jul 2012 12:00:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207311141300.8722@utopia.booyaka.com>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com> <1341224669-15231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com> <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35086 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2GaSAP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 14:00:15 -0400
In-Reply-To: <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Mike,

On Mon, 30 Jul 2012, Turquette, Mike wrote:

> On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> > So if we make a change like this one, it seems like we would basically 
> > expect it to break once we start doing anything meaningful with 
> > clk_prepare(), like using clk_prepare() for voltage scaling or 
> > something that requires I2C?  We'd also probably want to mark this 
> > with some kind of "HACK" comment.
> 
> Did you have anything in mind to start using clk_prepare?  I still hope 
> to get rid of it some day and replace that call with a combination of 
> clk_enable and a check like clk_enable_can_sleep.

Nothing that requires immediate attention.  Mostly am just trying to think 
through how to reconcile the clock and device management code that we have 
with what other SoC programmers are apparently implementing in their 
platform code.


- Paul
