From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 11/14] PM / AVR32: Use struct syscore_ops instead of sysdevs for PM
Date: Tue, 26 Apr 2011 19:14:13 +0200
Message-ID: <201104261914.14351.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172313.09712.rjw@sisk.pl> <1303820532.3125.12.camel@hcegtvedt>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303820532.3125.12.camel@hcegtvedt>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Mike Frysinger <vapier@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, April 26, 2011, Hans-Christian Egtvedt wrote:
> On Sun, 2011-04-17 at 23:13 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Convert some AVR32 architecture's code to using struct syscore_ops
> > objects for power management instead of sysdev classes and sysdevs.
> > 
> > This simplifies the code and reduces the kernel's memory footprint.
> > It also is necessary for removing sysdevs from the kernel entirely in
> > the future.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> 
> Thanks, nice work. Tested and run on hardware.

Thanks!

Rafael
