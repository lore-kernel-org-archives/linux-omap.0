From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a	module
Date: Wed, 25 Jun 2008 18:10:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BED2575@dbde02.ent.ti.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
	 <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
	 <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
	 <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com>
 <1214395879.24418.40.camel@mort>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41338 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459AbYFYMkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 08:40:37 -0400
In-Reply-To: <1214395879.24418.40.camel@mort>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, ext Felipe Balbi <me@felipebalbi.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > And like you said, if the defconfig is all modular (or all built-in)
> > the user/manufacturer/hacker can always change it later. Although
> > I defend that Reference Boards' defconfigs should be as modular
> > as possible.
>
> I totally agree: furthermore testing power features is damn easier if we
> can bisect the modules and zero on the offending driver.

I agree too. No contest.

On the other hand, the easiest way to find that something is broken is if
it is built-in in the kernel. Else, you could easily overlook some module
that you never loaded because it wasn't an area you worked on. For a recent
example of this, it is not very likely that I would have found that the
display driver was broken because if it were a module, I would rarely load
it. I caught it only because it was preventing a defconfig kernel from booting.

We do have an "allmodconfig" target. How about using that when you want to
bisect and find the broken driver?

My main bone of contention was the statement that there was no reason for
not building something as a module. There is a case for building drivers
into the kernel. Whether it is the best choice is something that depends
on what one is trying to achieve.

>
> And on top of that, having modules allows to makes it simpler to address
> in one go different boards and subarchitectures.

I'm afraid I don't understand. How would having a driver as a module or
built-in make a difference when targetting different boards?

- Anand
