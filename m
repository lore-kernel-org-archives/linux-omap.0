From: Tony Lindgren <tony@atomide.com>
Subject: Re: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 15:17:02 -0700
Message-ID: <20091020221701.GM12576@atomide.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49782 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZJTWQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 18:16:59 -0400
Content-Disposition: inline
In-Reply-To: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brett Graham <graham@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org

* Brett Graham <graham@rowland.harvard.edu> [091020 15:06]:
> I'm trying to mmap /dev/mem in python to access various registers on a
> gumstix overo (with an omap 3530 processor). Here is the code I'm
> using (as a minimal example):
> ----------------------------
> import os, mmap
> MAP_MASK = mmap.PAGESIZE - 1
> addr = (see below)
> 
> f = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)
> m = mmap.mmap(f, mmap.PAGESIZE, mmap.MAP_SHARED, mmap.PROT_WRITE |
> mmap.PROT_READ, offset=addr & ~MAP_MASK)
> m.seek(addr & MAP_MASK)
> c = m.read_byte()
> print c
> m.close()
> os.close(f)
> ----------------------------
> 
> If I use: addr = 0x48002178 everything works swimmingly. However, if I
> use: addr = 0x48088024 (or all the addresses I've tried > 0x48044000)
> I get the following error
> 
> Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020024
> Bus error
> 
> and python crashes. I'm basing the mmap flags and options off of
> devmem2.c. If I remove the O_SYNC flag from the os.open command, I can
> read and write to registers fine, but randomly I will get the
> Unhandled fault error and things will not work correctly.
> 
> Am I using the right command to write to the omap registers? should I
> be using the O_SYNC flag? Any ideas where these errors are coming
> from?

Sounds like you need to enable ick and fck for the device you're trying
to read.

Tony
