From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
Date: Fri, 6 Jan 2017 08:02:23 -0800
Message-ID: <20170106160222.GC2630@atomide.com>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
 <20170105171845.GK4310@atomide.com>
 <20170105175619.GA56877@google.com>
 <1483694849.3634.6.camel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483694849.3634.6.camel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org> [170106 01:28]:
> Hello Brian,
> 
> Am Donnerstag, den 05.01.2017, 09:56 -0800 schrieb Brian Norris:
> > On Thu, Jan 05, 2017 at 09:18:45AM -0800, Tony Lindgren wrote:
> > > 
> > > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170105 07:37]:
> > > > 
> > > > * Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org> [170105 06:57]:
> > > > > 
> > > > > To improve NAND safety we updated the partition layout.
> > > > > Added barebox backup partition and removed kernel and oftree
> > > > > partition. They are kept in ubi now.
> > > > What about the users with earlier partition tables?
> > > > 
> > > > Please read about "flag day" changes, typically they are not
> > > > acceptable.
> > > Adding Brian and Adam to Cc. Can you guys come up with some
> > > solution on this?
> > I don't have much context for this thread, and no I don't plan to
> > solve
> > your problems for you. But I can provide tips!
> > 
> > > 
> > > I'm suggesting we leave the kernel nodes empty and let u-boot
> > > populate them, so maybe you guys can discuss this on the related
> > > lists.
> > That's an option. I've worked with platforms that did something like
> > this, and that's really one of the only ways you can handle putting
> > partition information in the device tree. You're really hamstringing
> > yourself when you put all the partition information in the device
> > tree.
> > And it's just dumb once that gets codified in the kernel source tree.
> > 
> 
> In our case the bootloader does pass the partition table to the kernel.
> So it gets overwritten anyway. This was just more for backup, 
> if someone uses a different bootloader. But I'm fine with removing the
> nand partition table completely from the kernel device tree.
> Same with the SPI nor partition table.
> 
> I will send patches for this.

OK thanks! Also thank you Brian for your comments.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
