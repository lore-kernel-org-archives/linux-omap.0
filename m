From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: Android on N810 File System Problem
Date: Wed, 30 Apr 2008 12:45:23 +0300
Message-ID: <87fxt3y8uk.fsf@nokia.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	<48116F5C.9040009@googlemail.com>
	<20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	<87fxt7my4o.fsf@nokia.com>
	<20080427223248.GA5962@kedavra.cpe.vivax.com.br>
	<20080428233827.GE8449@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58897 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbYD3Jpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:45:42 -0400
In-Reply-To: <20080428233827.GE8449@atomide.com> (ext Tony Lindgren's message of "Mon\, 28 Apr 2008 16\:38\:28 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

"ext Tony Lindgren" <tony@atomide.com> writes:

> * Felipe Balbi <me@felipebalbi.com> [080427 15:31]:
>> On Sun, Apr 27, 2008 at 12:43:19PM +0300, Kalle Valo wrote:
>> > "ext Felipe Balbi" <me@felipebalbi.com> writes:
>> > 
>> > > Current linux-omap's head has all the necessary pieces to get n810
>> > > working. Touchscreen, keypad, ambient light sensor, led, usb, everything
>> > > is there.
>> > 
>> > What about sound?
>> 
>> I'm sure it'll come from alsa-devel soon.
>
> I've merged Jarkko's asoc patch to linux-omap for testing. Have not
> gotten any sound out of it on my n810 though.. Maybe some alsamixer
> settings issue?
>
> Kalle, do you have any tips on getting WLAN to work on n8x0?

Unfortunately no. It's not a big task, but proprietary umac.ko is the
biggest problem. It needs to be recompiled.

> Don't know if there's anything new there to you, but I posted some
> info on getting things to work with current linux-omap kernel at:
>
> http://www.muru.com/linux/n8x0/

That's really handy, thanks.

-- 
Kalle Valo
