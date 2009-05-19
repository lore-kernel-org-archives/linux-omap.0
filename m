From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Tue, 19 May 2009 09:42:40 +0300
Message-ID: <20090519094240.dbe5b959.jhnikula@gmail.com>
References: <200905091745.06435.luke@dashjr.org>
	<200905121818.13785.luke@dashjr.org>
	<20090513121219.43206b03.jhnikula@gmail.com>
	<200905190009.28222.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:64971 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbZESGkW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 02:40:22 -0400
Received: by ewy24 with SMTP id 24so4636348ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 23:40:23 -0700 (PDT)
In-Reply-To: <200905190009.28222.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: linux-omap@vger.kernel.org

On Tue, 19 May 2009 00:09:20 -0500
"Luke-Jr" <luke@dashjr.org> wrote:

> Yes, that change seemed to get me booting... however, with "rc6", the
> keyboard no longer works *at all*, and in neither rc4 nor rc6 does
> p54spi actually work.
> 
For me keyboard still works as partially (commit
0b2ce840c9fb58cf489bfdfc2d77f99a09a5dca3). I wonder what have caused it
to break during 2.6.30-rc since at quick look I don't point any special
from Tony's "Extra omap code in linux-omap tree" patches and patches
before those are from February?

git whatchanged arch/arm/mach-omap2/board-n800.c
git whatchanged drivers/input/keyboard/lm8323.c

> Tried setting up g_ether, but for some reason I couldn't get it to
> auto- configure (via Gentoo's boot scripts) for rc6.
> 
For me it works but usually only if cable has been plugged in while
booting. Same with Beagle as well. Any idea from MUSB guys?

> Is anyone actually trying to work on or maintain N8x0 support?

I think N8x0 support is a little bit behind from other boards. Lot of
active development is going around on newer and more open platforms like
Beagle and not all patches are necessary tested on N8x0 (or other boards
too!). Of course active hacker base helps to point out breakages.


-- 
Jarkko
