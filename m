From: Paul Walmsley <paul@pwsan.com>
Subject: Re: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 17:18:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910201716260.22645@utopia.booyaka.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34798 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZJTXSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 19:18:46 -0400
In-Reply-To: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brett Graham <graham@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org

On Tue, 20 Oct 2009, Brett Graham wrote:

> If I use: addr = 0x48002178 everything works swimmingly. However, if I
> use: addr = 0x48088024 (or all the addresses I've tried > 0x48044000)
> I get the following error
> 
> Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020024
> Bus error

0x40020024 != 0x48088024 ?  That's probably not the kernel's fault.


- Paul
