From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a module
Date: Thu, 26 Jun 2008 09:55:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BED26D5@dbde02.ent.ti.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
	 <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
	 <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
	 <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com>
	 <1214395879.24418.40.camel@mort>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BED2575@dbde02.ent.ti.com>
 <1214400227.24418.66.camel@mort>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:36928 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbYFZEZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 00:25:59 -0400
In-Reply-To: <1214400227.24418.66.camel@mort>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, Jouni Hogander <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > My main bone of contention was the statement that there was no reason for
> > not building something as a module. There is a case for building drivers
> > into the kernel. Whether it is the best choice is something that depends
> > on what one is trying to achieve.
>
> As Felipe wrote, it is easy to reconfigure a module to be build in than
> it is to get a build in and have it to be compilable and usable as
> module. Developing a module gives you for free the builtin case.
> The other way is not always true.

Agreed. That is correct.


> Your case of "let's veryfy all the modules at once by converting them to
> built-ins" is more the exception than the rule.

That wasn't what I said or meant. What I did want to bring out was that having
something built-in might give it more exposure to test by someone who wasn't
actively working on that area. And most bugs are caught by people other than
the active developers.


> > > And on top of that, having modules allows to makes it simpler to address
> > > in one go different boards and subarchitectures.
> >
> > I'm afraid I don't understand. How would having a driver as a module or
> > built-in make a difference when targetting different boards?
>
> I can do just one build and use the same binary to do the deployment to
> different boards.

This can still be done if you have everything built-in. Is there any reason for
such a all-built-in kernel not to work across boards?

At first glance to your email, I thought you had a valid point here. Thinking a
little more, I think your point is valid only if you had a module that should not
be loaded on a particular board. In such a case, you would anyway want to fix that
module.


> That's the direction the kernel is currently going to, with code that
> probes for OMAP version and uses the appropriate register addresses.
>
> The bootloader can pass the board type as option.

This can be done with a modular kernel as well as with an all-built-in kernel.

Yes, having a modular kernel is useful. And it is probably the way to go. But please
don't tell me that you can't do the same things with almost everything built-in.


The 2430 defconfig has almost everything modular, while the 3430 defconfig doesn't.
I propose we start a separate defconfig for the modular case or use allmodconfig.
Maybe even have this as the defconfig for the multi-omap kernel. If we keep the
individual defconfigs as a nearly all-built-in case, we can still get the best of
both worlds.

- Anand
