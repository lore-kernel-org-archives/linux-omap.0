From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 22 Mar 2012 10:33:56 -0700
Message-ID: <87r4wka6bf.fsf@ti.com>
References: <WC20120322110946.6413AA@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55980 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753578Ab2CVRd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 13:33:58 -0400
Received: by mail-yw0-f53.google.com with SMTP id j72so2325359yhj.40
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 10:33:57 -0700 (PDT)
In-Reply-To: <WC20120322110946.6413AA@terrafix.co.uk> (Joe Woodward's message
	of "Thu, 22 Mar 2012 11:09:46 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> Is system suspend broken on stock 3.3?

I hope not. :)

It *should* work, I'm using it regularily here, and "it works for me"
(I'm sure that's just what you want to hear.)  :)

> I have a working stock 3.2 (with patches to fix runtime_pm for DSS2), and system suspend works just fine!
>
> This is running on a variety of GUMSTIX boards (both OMAP3530 and AM3703-based).

I currently only have a 3530-based Gumstix Overo (although a
AM3xxx-based one is on the way, thanks Gumstix!), but it's working fine
for me on my Overo.

Stock v3.3 won't boot on Overo because of the smsc911x regulator issues
recently discusssed, so if you're using Overo, you also need the patch
in Tony's fix-smsc911x-regulator branch.

After that, suspend/resume is working fine for me using
omap2plus_defconfig.  I tried both with initramfs and with MMC rootfs.

Can you try without your board file changes, using vanilla v3.3 +
smsc911x fix above and using omap2plus_defconfig?

Also, please share the kernel command-line you're using.

Thanks,

Kevin
