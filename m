From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 08:20:43 +0300
Message-ID: <20080917082043.04c94e2d.jarkko.nikula@nokia.com>
References: <87tzcgi1gv.fsf@nokia.com>
	<alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com>
	<20080916184110.GA10733@frodo>
	<20080916232505.GC25885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23890 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYIQFVS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 01:21:18 -0400
In-Reply-To: <20080916232505.GC25885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, Kalle Valo <kalle.valo@nokia.com>, linux-omap@vger.kernel.org

On Tue, 16 Sep 2008 16:25:06 -0700
"ext Tony Lindgren" <tony@atomide.com> wrote:

> Hopefully we'll get all core 24xx and 34xx files integrated soon. But
> then there are tons of board-*.c files missing from mainline that
> probably need to be cleaned up a bit. 
> 
I think one good measure for this whole work when one can can run
Beagle or Overo with mainline kernel.

That would require some "spring-cleaning" effort and getting core,
TWL4030, etc. patches out but then it is much more easier to send
remaining board files and other drivers to their relevant lists.


Jarkko
