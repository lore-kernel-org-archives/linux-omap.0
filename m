From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: Hang on boot
Date: Mon, 11 Oct 2010 09:55:04 +0300
Message-ID: <1286780104.10205.32.camel@atlantis.mindbit.ro>
References: <AANLkTiknOwhUJny9WcYxROic+SP1eOcUmqbG7Kh9pPDY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:34229 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab0JKGzV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 02:55:21 -0400
In-Reply-To: <AANLkTiknOwhUJny9WcYxROic+SP1eOcUmqbG7Kh9pPDY@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Garland <johnnyg@cse.unsw.edu.au>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, 2010-10-11 at 14:09 +1100, John Garland wrote:
> Hi,
> 
> Both the dspbridge and master branch of linux-omap seem to hang when
> trying to boot (i.e. no output) on a beagleboard C2.
> This is with the new omap2plus_defconfig (as opposed to the old
> omap3_defconfig).
> 
> Is anybody else experiencing this or does anyone have any idea what
> could be causing this?
> 

Make sure you update your u-boot environment so that you have
console=ttyO2,115200 in your kernel command line (btw, it's ttyO2, not
tty02). It's been recently changed in the linux-omap tree (commit
d6e284d).

You'll probably also need to update your /etc/inittab.

Cheers,
Ionut.


