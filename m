From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Fwd: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 17:26:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910201723480.22645@utopia.booyaka.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>  <20091020221701.GM12576@atomide.com> <47b23c40910201615l1b1ab25ewd1dcae6b27728397@mail.gmail.com> <47b23c40910201616l2d5d454cs77948f7a7f167a14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45694 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbZJTX0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 19:26:23 -0400
In-Reply-To: <47b23c40910201616l2d5d454cs77948f7a7f167a14@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brett Graham <graham@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org

On Tue, 20 Oct 2009, Brett Graham wrote:

> If I run the following commads:
> devmem2 0x48004a40 w 0x0000038a # select 32kHz clock
> devmem2 0x48004a10 w 0x03007052 # enable iclk for gpt11
> devmem2 0x48004a00 w 0x03007000 # enable fclk for gpt11
> 
> which all run sensibly and alter the registers, then I try to previous
> minimum example on address 0x48088024 (TCLK for gpt11) I get the
> following error:
> Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020024
> Bus error
> 
> What puzzles me is that when I use devmem2 to read or write to the
> same register, everything works fine.

Consider running strace on devmem2 and comparing it to the strace of your 
Python code?  That should show you any differences.  If devmem2 works, 
it's unlikely to be a kernel problem.


- Paul
