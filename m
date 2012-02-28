From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is
 transferring data in PIO mode
Date: Tue, 28 Feb 2012 10:13:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202281012130.11716@utopia.booyaka.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025036.31613.67819.stgit@dusk> <4F423E28.3040404@ti.com> <alpine.DEB.2.00.1202211456160.25023@utopia.booyaka.com> <4F47A040.6030502@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4F47A040.6030502@ti.com>
Content-ID: <alpine.DEB.2.00.1202281012401.11716@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, 24 Feb 2012, Cousson, Benoit wrote:

> On 2/21/2012 11:02 PM, Paul Walmsley wrote:
>
> > Looks fine to me, although I'd suggest fixing the DMA workaround path as
> > well.
> 
> Mmm, I've tried to fix every instances of pdata in the code, you think I
> missed some?
> 
> I'll check again.
> 
> > Reviewed-by: Paul Walmsley<paul@pwsan.com>

I just doublechecked the code paths and looks like you covered them all.  
Sorry about the confusion.

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul
