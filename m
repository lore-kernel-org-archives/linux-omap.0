From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 09:32:12 +0300
Message-ID: <87y71rqo43.fsf@nokia.com>
References: <87tzcgi1gv.fsf@nokia.com>
	<alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com>
	<20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com>
	<20080917082043.04c94e2d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33917 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYIQGc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 02:32:28 -0400
In-Reply-To: <20080917082043.04c94e2d.jarkko.nikula@nokia.com> (Jarkko Nikula's message of "Wed\, 17 Sep 2008 08\:20\:43 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Jarkko Nikula <jarkko.nikula@nokia.com> writes:

> On Tue, 16 Sep 2008 16:25:06 -0700
> "ext Tony Lindgren" <tony@atomide.com> wrote:
>
>> Hopefully we'll get all core 24xx and 34xx files integrated soon. But
>> then there are tons of board-*.c files missing from mainline that
>> probably need to be cleaned up a bit. 
>> 
> I think one good measure for this whole work when one can can run
> Beagle or Overo with mainline kernel.

I really would like to run N800/N810 with mainline kernel (ie. with
Linus' tree), at least get it booting. For example, sound and
bluetooth are not that important for me right now. What kind of
cleanup is needed for that?

-- 
Kalle Valo
