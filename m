From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a module
Date: Wed, 25 Jun 2008 07:03:54 -0500
Message-ID: <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com> <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com> <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34261 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbYFYMED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 08:04:03 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

Hi,

On Wed, 25 Jun 2008 16:47:30 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
wrote:

> Actually there is. It really depends on what you want to do with the
> system.
> 
> For instance, the case where you are running a tight embedded system with
> a ramdisk filesystem - the modules would have to sit on the filesystem
and
> would occupy precious space there. You might be better off having
> everything built into the kernel.
> 
> That being said, in my opinion it should be possible to have everything
as
> modules with little difference in functionality. In this case if the OMAP
> HSMMC driver is not PM-friendly, then that should be fixed. Making it
build
> as a module is at best a __temporary__ solution as Jouni points out.
> 
> The choice of building drivers into the kernel or as modules should be
> left to whoever builds the kernel. The defconfigs make life easy during
> testing but otherwise there is little reason to change them.

That's true but 3430sdp is far from a tight embedded system. It's a full
fledged omap3430-based board with plenty of memory space for everything
we need.

On the other hand, building as module allow us to just unload the module
if it's causing problems like preventing retetion. Besides, at least in
case on the SDPs, most of the people will use nfs anyways, which makes
a lot easier to upload the new modules to the board allowing us to test
new features in a module without even rebooting the board, just by
rmmod/insmod.

Again, I agree with that with a tight embedded system, it's better to
have everything into the kernel, but then again, we have to believe
that every single piece of sw is working exactly the way it should,
which is not always true during the development process of our drivers.

At least hsmmc and musb drivers still have some stuff to be taken
care of. Having them as modules, would allow faster development
cycle with less reboots on the target board.

And like you said, if the defconfig is all modular (or all built-in)
the user/manufacturer/hacker can always change it later. Although
I defend that Reference Boards' defconfigs should be as modular
as possible.

My 2 cents ;-)

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

