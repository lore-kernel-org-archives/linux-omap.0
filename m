From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
Date: Fri, 12 Oct 2012 14:51:56 -0700
Message-ID: <20121012215156.GL30339@atomide.com>
References: <20120925092118.GJ31374@n2100.arm.linux.org.uk>
 <CAKdam57bpTJ94Gn=mKVw1Fm-76fVPp3DGjFuNu_HfesybM1hPg@mail.gmail.com>
 <87ipas2y4h.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1210111748010.5736@utopia.booyaka.com>
 <50784458.9080806@ti.com>
 <877gqv7imt.fsf@deeprootsystems.com>
 <20121012164202.GQ28061@n2100.arm.linux.org.uk>
 <877gqv4lmt.fsf@deeprootsystems.com>
 <20121012185426.GS28061@n2100.arm.linux.org.uk>
 <87lifbwhwd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lifbwhwd.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sourav <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [121012 13:34]:
>
> I'm not conviced (yet) that a mismatch is the root cause.  Yes, that's
> what the author of $SUBJECT patch assumed and stated, but I'm not
> pursuaded.  
> 
> If it's an improperly configured mux issue, then the UART will break
> whenever the device is actually omap_device_enable'd, whether in the
> driver or in the bus layer.

I tried booting n800 here with CONFIG_OMAP_MUX disabled, and no
change. Serial console output stops right when the console initializes.

Regards,

Tony
