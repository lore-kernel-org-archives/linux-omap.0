From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP
 block
Date: Sat, 21 Jan 2012 13:31:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201211323410.28153@utopia.booyaka.com>
References: <20120121071934.18707.64258.stgit@dusk> <20120121125522.GA19027@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120121125522.GA19027@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Sat, 21 Jan 2012, Greg KH wrote:

> On Sat, Jan 21, 2012 at 12:27:37AM -0700, Paul Walmsley wrote:
> > [ This series is targeted for merging during v3.3-rc ]
> > 
> > On v3.3-rc1, the OMAP serial console doesn't behave properly when
> > power management is enabled (the default with omap2plus_defconfig).
> > This seems to be due to a combination of a silicon bug in the UART IP
> > block and broken FIFO settings in the OMAP serial driver.
> > 
> > This patch series attempts to work around these problems.  The workarounds
> > are not perfect; see the patch descriptions for more details.
> > 
> > Tested on OMAP3530 BeagleBoard.  This series will need to be tested on
> > OMAP2 and OMAP4 before it is ready to merge.
> 
> Who is going to do that testing?

I will do it, although I do cling to the hope that others will help.

> When?  

I'll do it within the next two or three days, unless others beat me to it.

> Why isn't it done already?

That's always the question about testing, isn't it?

In fact, now that you mention it, why haven't these patches been tested 
yet on every possible combination of OMAP SoC and console UART?  
Unbelievable, how negligent people are.

> I guess this means I can ignore them for now, right?

Yes.  I'll follow up with a pull request (or revisions) after I've tested 
them on some OMAP2 and OMAP4 boards.


regards

- Paul
