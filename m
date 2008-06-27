From: Tony Lindgren <tony@atomide.com>
Subject: Re: N810 power problems, bootloader upgrade, won't boot
Date: Fri, 27 Jun 2008 10:24:34 +0300
Message-ID: <20080627072433.GA20119@atomide.com>
References: <20080626231358.GD9938@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63213 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbYF0HYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 03:24:37 -0400
Received: from cs78198178.pp.htv.fi ([62.78.198.178] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1KC8Jw-000KbK-JU
	for linux-omap@vger.kernel.org; Fri, 27 Jun 2008 07:24:36 +0000
Content-Disposition: inline
In-Reply-To: <20080626231358.GD9938@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

* green <greenfreedom10@gmail.com> [080627 02:14]:
> I've been having power problems with my N810.  These problems appear on startup 
> (see three links below) and are supposedly fix by a bootloader upgrade, so I 
> upgraded using the Maemo Diablo Fiasco image 
> "RX-44_DIABLO_4.2008.23-14_PR_COMBINED_MR0_ARM.bin".  Perhaps this has fixed 
> the problem, but it has caused another: now the N810 won't boot with the 
> kernels I build, nor will it boot with the zImage-n8x0-2008-05-15 test kernel 
> that Tony Lindgren provided recently.  By not booting I mean that I see the 
> NOKIA splash screen only; nothing else happens.
> 
> Any ideas what I need to do?  I'd rather not downgrade because of problems I've 
> had with the device suddenly powering off when idle [3].

You need to leave out the machine id hack patch now, that's no longer
needed as the diablo image seems to use the official machine id.

Tony

> 
> Thanks.
> 
> [1] https://bugs.maemo.org/show_bug.cgi?id=2673
> [2] http://www.internettablettalk.com/forums/showthread.php?p=196185
> [3] http://blog.homac.de/?p=58


