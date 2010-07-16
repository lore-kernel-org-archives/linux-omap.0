From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Fri, 16 Jul 2010 08:52:44 +0100
Message-ID: <20100716075243.GB16124@n2100.arm.linux.org.uk>
References: <20100714132255.GB3103@ucw.cz>
	<20100715.083450.193689911.Hiroshi.DOYU@nokia.com>
	<20100715084118.GB26212@n2100.arm.linux.org.uk>
	<20100715.120807.39160135.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100715.120807.39160135.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: khilman@deeprootsystems.com, Yoshiya.Hirase@nokia.com, pavel@ucw.cz, teerth@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 15, 2010 at 12:08:07PM +0300, Hiroshi DOYU wrote:
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> Date: Thu, 15 Jul 2010 10:41:18 +0200
> 
> > On Thu, Jul 15, 2010 at 08:34:50AM +0300, Hiroshi DOYU wrote:
> >> Russell, would it be possible to put this into your next merge queue?
> > 
> > I think it needs quite a bit of rework - I certainly don't like all
> > those CP15 register accesses there - that's asking for lots of ifdefs
> > to spring up as more CPUs are supported.
> >
> > Eg, what about ensuring that state such as iWMMXt on PXA CPUs is
> > properly restored?
> 
> Right. This arch specific part can be something like
> "suspend-v[3-7].S" to accomodate those differences

It's not quite that simple - things like iWMMXt aren't part of the ARM
arch specs.

> > We already have code which knows what needs to be saved across a
> > power-off transition - its what we use for our normal suspend/resume
> > functionality, so we should look at re-using that code for hibernate
> > as well.  We really don't want to be maintaining two sets of code
> > doing the same thing.
> 
> Could you explain which code you're refering for the existing one?

The code which handles saving state for the existing suspend/resume
support.  This code already saves the necessary state from CP15 and
any other state which needs to be saved prior to putting the system
into low power mode.

Every machine class which supports suspend today has their own chunk
of code which does this, normally called something like sleep.S
