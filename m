From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2]
 input: CMA3000 Accelerometer driver)
Date: Tue, 31 Aug 2010 10:44:46 +0100
Message-ID: <20100831104446.321fd4f4@lxorguk.ukuu.org.uk>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com>
	<20100829184904.GC26209@core.coreip.homeip.net>
	<36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
	<20100830214025.2f9677a1@lxorguk.ukuu.org.uk>
	<20100830204412.GA28711@core.coreip.homeip.net>
	<AANLkTims1CagvPZQjTmYrOVi8REeLVbyyt3kEY_tsCtx@mail.gmail.com>
	<20100830214355.GB28865@core.coreip.homeip.net>
	<AANLkTinPConD62Ky7mvMn2ZgS=V9+Q5YUdaF5Vma8mn+@mail.gmail.com>
	<20100830224352.GF28865@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43310 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756720Ab0HaJ1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 05:27:15 -0400
In-Reply-To: <20100830224352.GF28865@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <me@felipebalbi.com>, Hemanth V <hemanthv@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "kai.svahn@nokia.com" <kai.svahn@nokia.com>, "matthias.nyman@nokia.com" <matthias.nyman@nokia.com>

> 1. Input transport via evdev is very convenient
> 2. There is no other standard alternative
> 
> Once there is standard interface for such sensors they will happily use
> it and will not look back.

I think the fact that most of the interest in IIO is "how do we make an
IIO/Input bridge" speaks volumes.

> Sure, for a particular cell phone there is no ambiguity, the sensor has
> certain functionality assigned that is well known. But does this mean
> that we should not expect parts being reused at all anymore?

If non-input uses later need non-input interfaces they can switch to that
with an input bridge when there is one and when it happens, which
probably won't.

> I am unsure how you would play a game with GPS as an input device.

In a non-game context take a look at things like the British Museum
application that allows you to view wherever you are and as it was long
ago by fishing out a relevant photograph as you walk around. In a game
context can I suggest the Zombies game is an example ?

Alan
