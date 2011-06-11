From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Sat, 11 Jun 2011 22:56:36 +0200
Message-ID: <201106112256.37012.rjw@sisk.pl>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
	<201106102227.25391.rjw@sisk.pl>
	<20110611114239.GC2738@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110611114239.GC2738@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Saturday, June 11, 2011, Mark Brown wrote:
> On Fri, Jun 10, 2011 at 10:27:25PM +0200, Rafael J. Wysocki wrote:
> 
> > So, there are a few things to consider:
> 
> > * Can the device do things like DMA?
> > * Does the driver use a workqueue?
> > * Does it use timers?
> 
> > In all of the above cases your system suspend handling will require extra
> > care to make sure those things won't get in the way of the suspend process.
> 
> Yes, that's the quiesce operation I think myself or Alan mentioned.
> 
> > It's probably fair to say that everithing depends on the subsystem, what it
> > does and what it expects from the driver.  In the extreme case, when the
> > subsystem is like the platform bus type, the driver unfortunately is on its
> > own and has to deal with the whole complexity.
> 
> I'm pretty much only working with buses that have no infrastructure and
> for which power is essentially orthogonal to the control bus itself -
> that's a very large proportion of the embedded space.  It really feels
> like we could be doing a better job for drivers using these buses,
> there's a lot of similarities in what many of them need but I can never
> find the time to get my head round it confidently enough to actually
> propose anything.

I agree.  That's one of the reasons why I introduced the struct dev_power_domain
thing a while ago and the generic PM domains patchset I've just posted is a step
in that direction.

Thanks,
Rafael
