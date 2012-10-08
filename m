From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/omap: Replace board_ref_clock with enum values
Date: Mon, 8 Oct 2012 14:41:47 -0700
Message-ID: <20121008214146.GT13011@atomide.com>
References: <5063306E.8080200@gmail.com>
 <CADTbHxozV2UyJjWoDaK3acpDxbtDJDOoapiV19w3FSMZUdMtpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46002 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875Ab2JHVlt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:41:49 -0400
Content-Disposition: inline
In-Reply-To: <CADTbHxozV2UyJjWoDaK3acpDxbtDJDOoapiV19w3FSMZUdMtpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pankaj Jangra <jangra.pankaj9@gmail.com>
Cc: Vikram Narayanan <vikram186@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Pankaj Jangra <jangra.pankaj9@gmail.com> [120927 19:25]:
> Hi,
> 
> On Wed, Sep 26, 2012 at 10:12 PM, Vikram Narayanan <vikram186@gmail.com> wrote:
> > Use the enum for board_ref_clock from linux/wl12xx.h
> >
> > Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> > ---
> > I'm not subscribed to the list. So please keep me in Cc for the replies.
> >
> >  arch/arm/mach-omap2/board-omap4panda.c       |    3 +--
> >  arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> 
> Looks good.
> 
> Reviewed-by: Pankaj Jangra<jangra.pankaj9@gmail.com>

Thanks applying into omap fixes.

Tony
