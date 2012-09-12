From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Wed, 12 Sep 2012 17:15:57 +0000
Message-ID: <201209121715.58621.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de> <1347368390-31252-13-git-send-email-arnd@arndb.de> <CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pihet-XID, Jean" <j-pihet@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?iso-8859-1?q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, J Keerthy <j-keerthy@ti.com>, linux-omap@vger.k
List-Id: linux-omap@vger.kernel.org

On Wednesday 12 September 2012, Pihet-XID, Jean wrote:
> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/include/linux/platform_data/smartreflex-omap.h
> > similarity index 100%
> > rename from arch/arm/plat-omap/include/plat/voltage.h
> > rename to include/linux/platform_data/smartreflex-omap.h
> The filename should be voltage-omap.h. The header file is for a
> voltage layer which is used by other layers, one of them is the
> smartreflex driver code (in drivers/power/avs).
> The header file for the smartreflex driver is in
> include/linux/power/smartreflex.h.

Ok, makes sense. Changed now.

	Arnd
