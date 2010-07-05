From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Devkit8000: Use DIE id to initialize dm9000 MAC
 address
Date: Mon, 5 Jul 2010 16:49:56 +0300
Message-ID: <20100705134956.GE15951@atomide.com>
References: <1278308819-9531-1-git-send-email-kanru@0xlab.org>
 <20100705094432.GO15951@atomide.com>
 <AANLkTimnLo0b--CkMP1DO_RDuDngy_bi2DlKoy69DVY0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54631 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0GENuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 09:50:02 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimnLo0b--CkMP1DO_RDuDngy_bi2DlKoy69DVY0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kan-Ru Chen <kanru@0xlab.org>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

* Kan-Ru Chen <kanru@0xlab.org> [100705 14:48]:
> On Mon, Jul 5, 2010 at 5:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > How about adding a function for getting this from mach-omap2/id.c?
> > Other boards might want to use it too.
> 
> I had originally intended to do so, but I was not sure how to design the api.
> 
> omap_read_die_0(), omap_read_die_id_1() and so on? or a function that
> return those ids at once?
> 
> Any suggestions?

No preferences from me, up to you. But some TI people might have better
ideas on how future proof it will be.

If it's likely to change, the maybe set up struct omap_die_id to start
with.

Regards,

Tony
