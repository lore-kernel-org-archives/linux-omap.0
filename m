From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: N810 power problems, bootloader upgrade, won't boot
Date: Fri, 27 Jun 2008 04:44:31 -0500
Message-ID: <58fb6e9fe129a67226b5911d0d0dc3f3@felipebalbi.com>
References: <20080626231358.GD9938@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39406 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYF0Jod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 05:44:33 -0400
In-Reply-To: <20080626231358.GD9938@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green <greenfreedom10@gmail.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>



On Thu, 26 Jun 2008 18:13:59 -0500, green <greenfreedom10@gmail.com> wrote:
> I've been having power problems with my N810.  These problems appear on
> startup 
> (see three links below) and are supposedly fix by a bootloader upgrade,
so
> I 
> upgraded using the Maemo Diablo Fiasco image 
> "RX-44_DIABLO_4.2008.23-14_PR_COMBINED_MR0_ARM.bin".  Perhaps this has
> fixed 
> the problem, but it has caused another: now the N810 won't boot with the 
> kernels I build, nor will it boot with the zImage-n8x0-2008-05-15 test
> kernel 
> that Tony Lindgren provided recently.  By not booting I mean that I see
> the 
> NOKIA splash screen only; nothing else happens.
> 
> Any ideas what I need to do?  I'd rather not downgrade because of
problems
> I've 
> had with the device suddenly powering off when idle [3].

Diablo releases are using the oficial Machine ID for n810 hw,
so the hack in mach-types is not needed anymore.

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

