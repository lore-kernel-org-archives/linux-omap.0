From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/7] ARM / Samsung: Use struct syscore_ops for "core"
	power management
Date: Fri, 8 Jul 2011 20:12:07 +0200
Message-ID: <201107082012.07610.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201103280129.50192.rjw@sisk.pl>
	<20110327234521.GH9995@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110327234521.GH9995@trinity.fluff.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday, March 28, 2011, Ben Dooks wrote:
> On Mon, Mar 28, 2011 at 01:29:49AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Replace sysdev classes and struct sys_device objects used for "core"
> > power management by Samsung platforms with struct syscore_ops objects
> > that are simpler.
> > 
> > This generally reduces the code size and the kernel memory footprint.
> > It also is necessary for removing sysdevs entirely from the kernel in
> > the future.
> 
> Hmm, does it still allow the system to choose which bits are bound
> depending on the cpu being registered, as for the s3c stuff it isn't
> just about the suspend/resume, it's binding items that get registered
> early in the startup sequence?

Yes, it does, AFAICS.  It didn't change the bits that weren't directly
related to suspend/resume (at least that wasn't the intention).

That said, using sysdevs for the initialization of things the way you describe
will have to change anyway, because sysdevs are going to be removed entirely
from the kernel at one point.

Thanks,
Rafael
