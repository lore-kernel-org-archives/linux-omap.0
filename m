From: Tony Lindgren <tony@atomide.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 8 Mar 2010 18:46:02 -0800
Message-ID: <20100309024602.GQ2900@atomide.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
 <20100309004832.GK2900@atomide.com>
 <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53879 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab0CICoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 21:44:44 -0500
Content-Disposition: inline
In-Reply-To: <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100308 17:49]:
> On Mon, Mar 8, 2010 at 4:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100306 20:53]:
> 
> > If you don't have any serial output with that, then try this:
> >
> > - reset some branch to 4f2c49fedf
> > - make sure you have DEBUG_LL and EARLY_PRINTK enabled in your .config
> > - check that you have earlyprintk also in the kernel cmdline
> > - apply the following patch for the uncompress code
> >
> 
> This worked.  I was able to boot in with DEBUG_LL enabled and
> everything appears to be working properly.

OK, then that means the debug-macro.S changes for busyuart macro
are OK.
 
> Any other hints?  I'm going to start looking at the changes, I'm
> beginning to understand them more.

Well the next patch gets rid of the hardcoded port addresses.
The debug port number is stored in uncompress.h based on the
machine ID.

Maybe try this next: Reset your test branch to commit
0c8219f0302d0d27fda52c790d38406801e547ec, then take a look at
arch/arm/plat-omap/include/plat/uncompress.h in a text editor.
Then see if there's an entry for your board in __arch_decomp_setup.

Is the DEBUG_LL_OMAP7XX(1, herald) correct? Is port 1 the right
UART to use?

If there's no entry, then you need to add a DEBUG_LL_OMAP7XX line
suitable for your board.

If you see something like "Uncompressing Linux..." then your know
the uncompress.h part is working. Once you get that working, then
it's time to look at the debug-macro.S again, see the addruart
macro that reads the debug port number from UART1 scratchpad
register.

Regards,

Tony

