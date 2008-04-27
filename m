From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Android on N810 File System Problem
Date: Mon, 28 Apr 2008 02:04:17 +0300
Message-ID: <1209337457.8988.13.camel@mort>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	 <48116F5C.9040009@googlemail.com>
	 <20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	 <87fxt7my4o.fsf@nokia.com> <20080427223248.GA5962@kedavra.cpe.vivax.com.br>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63695 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbYD0XOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Apr 2008 19:14:12 -0400
In-Reply-To: <20080427223248.GA5962@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Kalle Valo <kalle.valo@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

On Mon, 2008-04-28 at 01:32 +0300, ext Felipe Balbi wrote:
> On Sun, Apr 27, 2008 at 12:43:19PM +0300, Kalle Valo wrote:
> > "ext Felipe Balbi" <me@felipebalbi.com> writes:
> > 
> > > Current linux-omap's head has all the necessary pieces to get n810
> > > working. Touchscreen, keypad, ambient light sensor, led, usb, everything
> > > is there.
> > 
> > What about sound?
> 
> I'm sure it'll come from alsa-devel soon.

I also wonder if any kernel to userspace interface has changed since we
released the FW: that could compromise the execution of system services.

It would be probably good to check if any "obsolete interface" option
has to be enabled when configuring the new kernel.

-- 
Cheers, Igor

---

Igor Stoppa
Next Generation Software
Nokia Devices R&D - Helsinki
