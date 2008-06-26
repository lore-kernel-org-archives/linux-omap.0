From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a module
Date: Thu, 26 Jun 2008 02:28:59 -0500
Message-ID: <2aa617f9c1b78b05e445377b9865041f@felipebalbi.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com> <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com> <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BE47192@dbde02.ent.ti.com> <863b7a523c5b5b6b6898e2d82fab6dda@felipebalbi.com> <1214395879.24418.40.camel@mort> <5A47E75E594F054BAF48C5E4FC4B92AB022BED2575@dbde02.ent.ti.com> <1214400227.24418.66.camel@mort> <5A47E75E594F054BAF48C5E4FC4B92AB022BED26D5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60910 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbYFZH3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 03:29:06 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BED26D5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: igor.stoppa@nokia.com, Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

Hi,

On Thu, 26 Jun 2008 09:55:43 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
wrote:

> That wasn't what I said or meant. What I did want to bring out was that
> having
> something built-in might give it more exposure to test by someone who
> wasn't
> actively working on that area. And most bugs are caught by people other
> than
> the active developers.

Not really, another usecase for modular kernel is that we don't wanna
add e.g. tea (radio) driver for n810 cuz it doesn't have that chip.
With modular kernel with proper MODULE_ALIAS() and udev, you just
flash the same kernel and modules in both n800 and n810 and tea driver
would only be probed in n800.

I think this is what Igor meant when we said about validation across
boards.

> 
> 
> At first glance to your email, I thought you had a valid point here.
> Thinking a
> little more, I think your point is valid only if you had a module that
> should not
> be loaded on a particular board. In such a case, you would anyway want to
> fix that
> module.

Or you rely on udev rules and keep the main kernel code smaller.

> Yes, having a modular kernel is useful. And it is probably the way to go.
> But please
> don't tell me that you can't do the same things with almost everything
> built-in.

some stuff you really can't. If your mmc driver get stuck somewhere, you
can't modprobe -r -f omap_hsmmc and restart your work with a built-in
mmc driver. With modular kernel, we really can do it: forcefully remove
the driver and reset the controller, this would give us oportunity to
analyze logs and try again by reloading the module.

With a built-in kernel, the only way out is reboot.

> The 2430 defconfig has almost everything modular, while the 3430
defconfig
> doesn't.
> I propose we start a separate defconfig for the modular case or use
> allmodconfig.
> Maybe even have this as the defconfig for the multi-omap kernel. If we
> keep the
> individual defconfigs as a nearly all-built-in case, we can still get the
> best of
> both worlds.

The thins is that normaly you'd have udev running anyways, and it would
automatically load modules based on /sys and correct MODULE_ALIAS()
and that's already another thing to test that can't be tested with built-in
modules.

We know that several omap drivers are missing MODULE_ALIAS() and recently
I've
added it to all twl4030 drivers for that purpose.

We can now rely that udev will correctly load the necessary module when we
need it. And when I stated that there's no reason for not building
everything as dynamic module for omaps, I was considering that we have
enough memory in our boards and generaly developers will use NFS
root file system anyways.

I think this discussion is now way too long for something really
simple: For development purposes on SDPs, dynamic linked modules
can increase the development cycle by decreasing the amount of
build/flash/reboot cycles.

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

