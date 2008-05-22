From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: MMC/SD cards hotplug scenario
Date: Thu, 22 May 2008 20:39:39 +0000
Message-ID: <1211488779.6430.12.camel@mort>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
	 <20080521073017.GB23427@flint.arm.linux.org.uk>
	 <005d01c8bb25$63345fe0$538918ac@ent.ti.com>
	 <20080521203202.6d84a02b@mjolnir.drzeus.cx>
	 <0680EC522D0CC943BC586913CF3768C0015799CFD8@dbde02.ent.ti.com>
	 <20080522200123.GS15328@flint.arm.linux.org.uk>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59215 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296AbYEVVAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 17:00:19 -0400
In-Reply-To: <20080522200123.GS15328@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, Pierre Ossman <drzeus@drzeus.cx>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
On Thu, 2008-05-22 at 21:01 +0100, ext Russell King - ARM Linux wrote:

> Basically, what I'm trying to say is that ejecting any medium randomly
> from the system is _always_ going to result in problems of some nature.
> Some of which you can reduce the impact from, others are fairly terminal.
> The only safe solution is the unmount, wait for data to be written, and
> then eject the card.

from this point of view it is a watered down version of "what happens
when the power is removed abruptly", which unfortunately cannot really
be avoided on battery powered devices with removable battery.

If the system is supposed to survive such cases, then ext2 is probably
not the best choice and a journaling fs (ext3 ?) should be considered.

With MMC even the way the power fails (vcore fading away before/after
vio) affects the possibility of the embedded uC b0rking. So it needs to
be addressed also at board HW level.

This of course cannot be really controlled when the MMC is removed from
the slot, unless there is a sensor on the MMC lid.

Sensor that could be used for an emergency, controlled powerdown, with
no sync.

But on the Tablets we instead show a warning and tell the user to be
nice and close back the lid: UI designers prefer such approach.

Just my 2 cents.

-- 
Cheers, Igor

---

Igor Stoppa
Nokia Devices R&D - Helsinki
