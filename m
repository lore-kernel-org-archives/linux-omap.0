From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: OMAP: Fix oops due to NULL pdata in DT boot
Date: Tue, 28 Feb 2012 09:28:51 -0800
Message-ID: <20120228172851.GA13653@kroah.com>
References: <20120126024903.31613.24730.stgit@dusk>
 <20120126025036.31613.67819.stgit@dusk>
 <4F4D0D44.3010604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F4D0D44.3010604@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 28, 2012 at 06:22:12PM +0100, Cousson, Benoit wrote:
> The following commit: be4b0281956c5cae4f63f31f11d07625a6988766
> (tty: serial: OMAP: block idle while the UART is transferring data in PIO mode),
> is introducing an oops if OMAP is booted using device tree blob because
> the pdata will not be initialized.

Is that something that happens today on systems?  Does this need to go
in for 3.3-final, or can it wait for 3.4?

thanks,

greg k-h
