From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2xxx: PM: fix OMAP2xxx-specific UART idle bug
 in v3.3
Date: Thu, 9 Feb 2012 17:52:25 -0800
Message-ID: <20120210015225.GO1426@atomide.com>
References: <alpine.DEB.2.00.1202091822170.5059@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202091822170.5059@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [120209 16:52]:
> 
> [ This patch is targeted for v3.3-rc ]
> 
> On OMAP2420-based systems, the PM code ignores the state of the UART
> functional clocks when determining what idle state to enter.  This
> breaks the serial port now that the UART driver's clock behavior can
> be controlled via the PM autosuspend timeout.
> 
> To fix, remove the special-case idle handling for the UARTs in the
> OMAP2420/2430 PM idle code added by commit
> 4af4016c53f52b26461b8030211f8427a58fa5ed ("OMAP3: PM: UART: disable
> clocks when idle and off-mode support").
> 
> Tested on Nokia N800.  This patch is a collaboration between Tony
> Lindgren <tony@atomide.com> and Paul Walmsley <paul@pwsan.com>.

Glad to see this piece of code finally gone with runtime PM :)

Applying into fixes.

Regards,

Tony
