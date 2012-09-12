From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Wed, 12 Sep 2012 19:40:56 +0200
Message-ID: <CAN5iSWr6FOBZYPD4FaZU0u6vOvk=6AoE4UmZ5c3guEg8mAU+8w@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
	<1347368390-31252-13-git-send-email-arnd@arndb.de>
	<CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
	<201209121715.58621.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201209121715.58621.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, J Keerthy <j-keerthy@ti.com>, linux-omap@vger.kerne
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 7:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 September 2012, Pihet-XID, Jean wrote:
>> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/include/linux/platform_data/smartreflex-omap.h
>> > similarity index 100%
>> > rename from arch/arm/plat-omap/include/plat/voltage.h
>> > rename to include/linux/platform_data/smartreflex-omap.h
>> The filename should be voltage-omap.h. The header file is for a
>> voltage layer which is used by other layers, one of them is the
>> smartreflex driver code (in drivers/power/avs).
>> The header file for the smartreflex driver is in
>> include/linux/power/smartreflex.h.
>
> Ok, makes sense. Changed now.
Great, thanks!

Jean
>
>         Arnd
