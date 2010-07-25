From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH 6/7] save and restore etm state across core OFF modes
Date: Sun, 25 Jul 2010 22:38:51 +0300
Message-ID: <20100725193851.GA14399@shisha.kicks-ass.net>
References: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
 <1280077520-7538-7-git-send-email-virtuoso@slind.org>
 <AANLkTinmSJ6dtgqmyuk9CArniPEvEp7TrXauvGxLxv7x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinmSJ6dtgqmyuk9CArniPEvEp7TrXauvGxLxv7x@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 25, 2010 at 12:34:22 -0600, Hari Kanigeri wrote:
> > +config ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> > + =9A =9A =9A bool "Enable hardware emulation context save and rest=
ore"
> > + =9A =9A =9A depends on ARCH_OMAP3
>=20
> -- Shouldn't this be depends on OMAP3_EMU instead ?

Not really. OMAP3_EMU will enable ETM/ETB drivers within omap, but this
particular patch is also needed if you're using an external hardware
debugger to debug code across OFF modes.

> > + =9A =9A =9A default y
>=20
> -- As this is debug option, can you keep this "n" by default ?

This option allows for enabling certain debugging functionality in runt=
ime
(via a sysfs file), which is turned off by default. It is debatable whe=
ther
this option should default to 'y' or 'n', seeing as it doesn't add much
overhead to the normal usecase.

> > + =9A =9A =9A help
> > + =9A =9A =9A =9A This option enables JTAG & ETM debugging across p=
ower states.
> > + =9A =9A =9A =9A With out this option emulation features are reset=
 across OFF
> > + =9A =9A =9A =9A mode state changes.

But I see that the wording is misleading and unclear, so I'll try to co=
me
up with something more descriptive.

Regards,
--
Alex
