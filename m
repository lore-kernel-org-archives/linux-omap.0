From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP
 block
Date: Sun, 22 Jan 2012 07:04:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201220609290.26641@utopia.booyaka.com>
References: <20120121071934.18707.64258.stgit@dusk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, greg@kroah.com
Cc: Govindraj Raja <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 21 Jan 2012, Paul Walmsley wrote:

> [ This series is targeted for merging during v3.3-rc ]
> 
> On v3.3-rc1, the OMAP serial console doesn't behave properly when
> power management is enabled (the default with omap2plus_defconfig).
> This seems to be due to a combination of a silicon bug in the UART IP
> block and broken FIFO settings in the OMAP serial driver.
> 
> This patch series attempts to work around these problems.  The workarounds
> are not perfect; see the patch descriptions for more details.
> 
> Tested on OMAP3530 BeagleBoard.  This series will need to be tested on
> OMAP2 and OMAP4 before it is ready to merge.

Just did a quick test on an OMAP4430 ES2 Pandaboard and the 
(OMAP2420-based) N800.  This series has no obvious effect on either N800 
or OMAP4430 Pandaboard, aside from the expected increase in interrupts in 
the non-CPUIdle case.  Probably this is due to the relative immaturity of 
the PM code on those two chip families.


- Paul
