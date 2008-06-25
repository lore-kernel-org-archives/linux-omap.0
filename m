From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as
	a	module
Date: Wed, 25 Jun 2008 16:23:47 +0300
Message-ID: <1214400227.24418.66.camel@mort>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
	 <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
	 <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
	 <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com>
	 <1214395879.24418.40.camel@mort>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BED2575@dbde02.ent.ti.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31792 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbYFYNen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 09:34:43 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BED2575@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, Jouni Hogander <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2008-06-25 at 18:10 +0530, ext Gadiyar, Anand wrote:

> My main bone of contention was the statement that there was no reason for
> not building something as a module. There is a case for building drivers
> into the kernel. Whether it is the best choice is something that depends
> on what one is trying to achieve.

As Felipe wrote, it is easy to reconfigure a module to be build in than
it is to get a build in and have it to be compilable and usable as
module. Developing a module gives you for free the builtin case.
The other way is not always true.

Your case of "let's veryfy all the modules at once by converting them to
built-ins" is more the exception than the rule.

> > And on top of that, having modules allows to makes it simpler to address
> > in one go different boards and subarchitectures.
> 
> I'm afraid I don't understand. How would having a driver as a module or
> built-in make a difference when targetting different boards?

I can do just one build and use the same binary to do the deployment to
different boards.

That's the direction the kernel is currently going to, with code that
probes for OMAP version and uses the appropriate register addresses.

The bootloader can pass the board type as option.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
