From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Wed, 7 Dec 2011 00:46:32 +0000
Message-ID: <20111207004632.15c2a5d4@bob.linux.org.uk>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
	<874nxd5j0f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <874nxd5j0f.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 06 Dec 2011 16:21:20 -0800
Kevin Hilman <khilman@ti.com> wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > Converting uart driver to adapt to pm runtime API's.
> > Code re-org + cleanup.
> > Moving some functionality from serial.c to omap-serial.c
> 
> Alan, can you confirm your Ack's are still valid on the drivers/tty
> parts of this series?  It has gone through quite a few changes since
> your original ack.

Yes
