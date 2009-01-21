From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Is anybody else having problems with SDHC cards on Beagleboard?
Date: Wed, 21 Jan 2009 09:34:44 +0200
Message-ID: <20090121093444.314804f6.jarkko.nikula@nokia.com>
References: <1232455118.6982.14.camel@surfer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18389 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbZAUHe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 02:34:57 -0500
In-Reply-To: <1232455118.6982.14.camel@surfer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Hagood <david.hagood@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 20 Jan 2009 06:38:38 -0600
"ext David Hagood" <david.hagood@gmail.com> wrote:

> I have been trying to bring up a Beagleboard as a development platform
> for a project at work, but I am having a killer problem: any significant
> access of the memory card (a class 8 SDHC 8G card) will die with a
> transfer error, followed by about 10 failed sector accesses, followed by
> the system dying.
> 
> I've tried 2 different Beagleboards and 3 different cards by 2 different
> manufacturers, and the problem is repeatable on all permutations. I've
> put the cards into a card reader on my workstation and done a "dd
> if=/dev/sdf of=/dev/null" to verify the cards aren't wedged.
> 
For me both 2 GB microSD and 8 GB class 4 microSDHC cards are working
fine. E.g. no problems with these commands:

dd if=/dev/zero of=foo bs=1M count=500
dd if=foo of=/dev/null


My linux-omap head is

commit 45e5c5ffd32ade5a21a5e87b4040072590ec3ae1
Merge: c699464... 1de9e8e...
Author: Tony Lindgren <tony@atomide.com>
Date:   Sun Jan 18 14:08:53 2009 +0200

    Merge current mainline tree into linux-omap tree

And kernel is built with "make omap3_beagle_defconfig".


Jarkko
