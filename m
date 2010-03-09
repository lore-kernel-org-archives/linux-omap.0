From: Tony Lindgren <tony@atomide.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Tue, 9 Mar 2010 07:56:37 -0800
Message-ID: <20100309155636.GS2900@atomide.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
 <20100309004832.GK2900@atomide.com>
 <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
 <20100309024602.GQ2900@atomide.com>
 <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56192 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0CIPzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 10:55:17 -0500
Content-Disposition: inline
In-Reply-To: <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100308 19:03]:
> On Mon, Mar 8, 2010 at 6:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> Alright, I found it.  0c8219f0302d0d27fda52c790d38406801e547ec removed
> this code from uncompress.h:
> 
>     -               if (check_port(uart, shift))
>     -                       break;
> 
> which was in a while loop in putc(), with check_port defined as:
> 
>     #define UART_OMAP_MDR1         0x08    /* mode definition register */
>     #define check_port(base, shift) ((base[UART_OMAP_MDR1 << shift] & 7) == 0)
> 
> and shift = 0.  Without the break, putc() was silent.  If I put in
> similar code back into putc():
> 
>     +       if ((uart_base[0x08] & 7) != 0)
>     +               return;
> 
> it boots.
> 
> Unfortunately, I don't have access to the serial console, so I have no
> idea if any of the serial port work was actually working (the Herald
> is a phone, and the only output I have is USB, which can act as
> serial, but I'm ill-equipped to make that work).  I suspect this is
> always returning true, and as such we're not getting serial output
> through the uncompress.  Not sure what's needed to fix this, but at
> least that little bit of code makes it boot for me.

OK. It's not a bug it's a feature :)

If you don't have anything connected to the serial port, then
DEBUG_LL should not do anything as it just waits for fifo to empty.

Sounds like we should either have most of uncompress.h in ifdef
CONFIG_DEBUG_LL so it does not do anything unless set.

We may also want to also define DEBUG_LL_OMAP_NONE in uncompress.h
to allow booting systems with no serial port with DEBUG_LL set,
but I don't know if that's really needed.

Does your system boot without any patches if DEBUG_LL is not set
in your .config?

Regards,

Tony 
