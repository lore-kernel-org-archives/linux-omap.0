From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Thu, 7 Oct 2010 13:47:30 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB9FF5FA@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <AANLkTim_x=AykoGMZkHTPpXkX=6k+QA04VetqY56c57G@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC09@dbde02.ent.ti.com>
 <AANLkTikMmqe0ozTLY5qc8O3k=_vLAa1n2PB7cYsrEuR7@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC13@dbde02.ent.ti.com>
 <AANLkTikTmBxjRfy-0Ks_iJk2O7+jMYoKk6WChyO21wDW@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC47@dbde02.ent.ti.com>
 <AANLkTik9XBxRiV-r=tWoegiYtzmXKUDy9SzfBKjGz3Cz@mail.gmail.com>
 <20101007000418.GE4859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36992 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407Ab0JGIRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 04:17:37 -0400
In-Reply-To: <20101007000418.GE4859@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Thursday, October 07, 2010 5:34 AM
> To: Ohad Ben-Cohen
> Cc: G, Manjunath Kondaiah; linux-omap@vger.kernel.org
> Subject: Re: NOTE: hwmod changes merged to linux-omap master 
> for testing
> 
> * Ohad Ben-Cohen <ohad@wizery.com> [101004 15:21]:
> > On Mon, Oct 4, 2010 at 2:52 PM, G, Manjunath Kondaiah 
> <manjugk@ti.com> wrote:
> > > Remove nosmp from your bootargs and try.
> > 
> > Indeed, it doesn't boot.
> > 
> > wizery.com/ohad/blaze-linux-omap-smp.txt.gz
> 
> FYI, posted a fix for this:
> 
> http://patchwork.kernel.org/patch/237401/
> 

Thanks! It boots up(both with smp and nosmp options in bootargs) on omap4 blaze.
-Manjunath