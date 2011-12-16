From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] OMAP serial device tree support
Date: Fri, 16 Dec 2011 14:17:31 -0800
Message-ID: <20111216221731.GS32251@atomide.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <87d3brnpsi.fsf@ti.com>
 <20111214171843.5f638874@bob.linux.org.uk>
 <20111214182710.GC8039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111214182710.GC8039@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-omap@vger.kernel.org

* Greg KH <greg@kroah.com> [111214 10:27]:
> On Wed, Dec 14, 2011 at 05:18:43PM +0000, Alan Cox wrote:
> > On Wed, 14 Dec 2011 07:20:13 -0800
> > Kevin Hilman <khilman@ti.com> wrote:
> > 
> > > Greg, Alan,
> > > 
> > > Rajendra Nayak <rnayak@ti.com> writes:
> > > 
> > > > v3 is rebased on top of the latest serial runtime
> > > > patches[1] and boot tested with/without DT on OMAP4
> > > > SDP and OMAP4 Panda boards.
> > > 
> > > With your ack on the drivers/tty/* stuff, I can queue this via the
> > > OMAP tree on top of the runtime PM conversion that it depends on.
> > 
> > Go for it
> 
> Fine with me as well.

For the record, I'll apply these directly into the omap uart
branch as Kevin is on vacation. 

Regards,

Tony
