From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH/RFC] OMAP2: serial.c: Fix number of uarts in
 early_init
Date: Thu, 25 Feb 2010 10:57:34 -0800
Message-ID: <20100225185734.GI28173@atomide.com>
References: <1267090819-17796-1-git-send-email-swirl@gmx.li>
 <20100225184355.GF28173@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF5EC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF5EC@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Thomas Weber <swirl@gmx.li>, "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Weber <weber@corscience.de>
List-Id: linux-omap@vger.kernel.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100225 10:51]:
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, February 26, 2010 12:14 AM
> > To: Thomas Weber; Aguirre, Sergio
> > Cc: linux-omap@vger.kernel.org; Russell King; Kevin Hilman; Shilimkar, Santosh; Pandita, Vikram;
> > Syed, Rafiuddin; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Thomas Weber
> > Subject: Re: [RESEND][PATCH/RFC] OMAP2: serial.c: Fix number of uarts in early_init
> > 
> > * Thomas Weber <swirl@gmx.li> [100225 01:36]:
> > >
> > > The omap_serial_early_init prints the following errors:
> > >
> > > Could not get uart4_ick
> > > Could not get uart4_fck
> > >
> > > because all the uarts available in omap_uart[] will be initialized.
> > > Only omap4430 and omap3630 have 4 uarts at the moment.
> > > This patch reduces the number of uarts when cpu is not omap4430 or
> > > omap3630.
> > 
> > ..and I only patched omap_serial_init and forgot about
> > the omap_serial_early_init..
> > 
> > Looks good to me, Sergio, care to test and Ack this? Also, sounds
> > like we still need to patch omap4 for uart4 for the clocks.
> > 
> Clocks will be take care automatically by "nr_ports" for omap4 too
> with this patch. Below clock changes are just cosmetic ones, isn't it ?
> 
> Am I missing something?

Yes sorry, I'm referring to "[RFC][PATCH 0/3] OMAP3630: UART4 startup"
series to fix the uart4 issues for 3630, not omap4.

Regards,

Tony
