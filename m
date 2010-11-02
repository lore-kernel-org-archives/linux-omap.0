From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: cleanup Kconfig stuff
Date: Tue, 2 Nov 2010 21:43:30 +0200
Message-ID: <AANLkTimuT8__KJE1V9f8PoFCxUjYW6n=35mLH4wBVdvM@mail.gmail.com>
References: <1288656853-4625-1-git-send-email-felipe.contreras@gmail.com>
	<1288656853-4625-3-git-send-email-felipe.contreras@gmail.com>
	<20101102131146.GA21476@opensource.wolfsonmicro.com>
	<AANLkTim6E+e=D88C8g+YDVwS1D5JPeXvVRw-JVoVxh2i@mail.gmail.com>
	<20101102143534.GG21476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52745 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0KBTnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 15:43:33 -0400
In-Reply-To: <20101102143534.GG21476@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-usb <linux-usb@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Greg KH <greg@kroah.com>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>, David Brownell <dbrownell@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>, Hao Wu <hao.wu@intel.com>, Alan Cox <alan@linux.intel.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mike Rapoport <mike@compulab.co.il>

On Tue, Nov 2, 2010 at 4:35 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 02, 2010 at 04:02:18PM +0200, Felipe Contreras wrote:
>> On Tue, Nov 2, 2010 at 3:11 PM, Mark Brown
>
>> > This default is not suitable for non-OMAP platforms, it should be
>> > conditional on OMAP or something if we're going to do this (though
>> > generally we handle this with defconfigs rather than in Kconfig).
>
>> This would only be enabled when TWL4030_CORE is enabled, so non-OMAP
>> platforms would not get affected.
>
> TWL4030 can be enabled on other platforms - it's not tied to OMAP
> (mostly to enable build coverage).

Yes, but if you are manually enabling TWL4030_CORE and REGULATOR,
REGULATOR_TWL4030 makes sense. If somebody doesn't want it for some
reason, it can be manually disabled.

>> I guess you have seen the complaint from Linus regarding ARM relying
>> too much on defconfigs. This helps in order to simplify defconfigs,
>> and eventually getting rid of them completely.
>
> This solution doesn't seem like it scales so well either, it just shi=
fts
> it into the Kconfig files (where everything is all in central files
> shared by everyone which has its own problems). =C2=A0Certainly the g=
oal of
> replacing defconfig files with Kconfig seems unattainable.

The difference is that Kconfig files are needed, and part of linux
itself. The defconfig files should be optional, there are many, and
not necessarily in the linux tree (e.g. meego kernel configs).

However, even if you forget about Kconfig vs defconfig, it should be
possible to create a .config file from nothing, and when you do that,
having REGULATOR_TWL4030 enabled when you enable REGULATOR support
just makes sense (if you have enabled TWL4030_CORE).

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
