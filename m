From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 12:54:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031249590.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com> <20120203230720.28666cc6@notabene.brown> <20120203122053.GF1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120203122053.GF1275@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: NeilBrown <neilb@suse.de>, Govindraj <govindraj.ti@gmail.com>, khilman@ti.com, greg@kroah.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 3 Feb 2012, Russell King - ARM Linux wrote:

> If there's an on-going transmission, why is the runtime PM count zero,
> meaning that the UART can sleep at the point where serial_omap_tx_empty()
> is being called - and obviously there's still characters in the FIFO?

In the case of OMAP, that's the point of the idle protocol.  If there's 
data left in the TX FIFO, the UART should prevent the rest of the chip 
from cutting its clocks until the TX FIFO is drained.  Even if the MPU has 
requested that the UART clocks be cut.

Of course, there may well be a bug that prevents this from working the 
way it was intended.


- Paul
