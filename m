From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Sat, 18 Sep 2010 01:07:51 +0200
Message-ID: <201009180107.51664.rjw@sisk.pl>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
	<20100917121958.1dbb57af.akpm@linux-foundation.org>
	<4C93DC4E.5020506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C93DC4E.5020506@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@stericsson.com>, "Granados Dorado,
	Roberto" <x0095451@ti.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vger.kernel.org>, Romit Dasgupta <ro.m>
List-Id: linux-omap@vger.kernel.org

On Friday, September 17, 2010, Nishanth Menon wrote:
> Andrew Morton had written, on 09/17/2010 02:19 PM, the following:
> > On Thu, 16 Sep 2010 20:29:33 -0500
> > Nishanth Menon <nm@ti.com> wrote:
> > 
> [...]
> >>
> >>  Documentation/power/00-INDEX |    2 +
> >>  include/linux/opp.h          |  136 +++++++++++++
> >>  kernel/power/Kconfig         |   14 ++
> >>  lib/Makefile                 |    2 +
> >>  lib/opp.c                    |  440 ++++++++++++++++++++++++++++++++++++++++++
> > 
> > ./lib/ is an unusual place to put a driver-like thing such as this. 
> > The lib/ directory is mainly for generic kernel-wide support things. 
> > I'd suggest that ./drivers/opp/ would be a better place.
> we had an interesting debate on this topic on the the thread starting
> http://marc.info/?l=linux-arm-kernel&m=128465710624421&w=2
> 
> It really does not provide any driver like feature here. it is just a 
> bunch of helper functions which any SOC framework can use to build up to 
> implement either:
> a) cpufreq implementation with various OPPs
> b) bootup in a specific opp in a set of supported OPPs and stay there 
> (e.g. mpurate support on OMAP platforms)

Generally, some files under drivers/base/power contain helper functions of
similar nature.  You can put it in there, as far as I'm concerned.

> I had considered putting it in drivers/power, but it looks to contain 
> mostly regulator stuff, the other alternative would be to include it in 
> kernel/power or as Kevin H, Linus W and you mention drivers/opp
> 
> Personally, I dont have a strong feeling about it as long as it is 
> reusable across SOCs and am hoping to hear some alignment :).
> 
> > 
> >> ...
> >>
> >> +/*
> >> + * Initialization wrapper used to define an OPP.
> >> + * To point at the end of a terminator of a list of OPPs,
> >> + * use OPP_DEF(0, 0, 0)
> >> + */
> >> +#define OPP_DEF(_enabled, _freq, _uv)	\
> >> +{						\
> >> +	.enabled	= _enabled,		\
> >> +	.freq		= _freq,		\
> >> +	.u_volt		= _uv,			\
> >> +}
> > 
> > OPP_DEF is a somewhat atypical name.  OPP_INITIALIZER would be more
> > conventional.
> Thanks. will incorporate this in v2 of my patchset.
> 
> > 
> > However OPP_DEF has no usage in this patch so perhaps this can be
> > removed?
> there were a few OMAP followon patches from
> http://marc.info/?l=linux-omap&m=128152135801634&w=2
> which will actually use this for OMAP3 platform.

Still, the $subject patch doesn't use it.  So perhaps add it in a separate patch?

> >> +static LIST_HEAD(dev_opp_list);
> > 
> > There's no locking for this list.  That's OK under some circumstances,
> > but I do think there should be a comment here explaining this apparent
> > bug: why is no locking needed, what are the lifetime rules for entries
> > on this list.
> Locking:
> arrgh.. my bad.. I had documented it in the missing and later on posted 
> opp.txt http://marc.info/?l=linux-arm-kernel&m=128473931626114&w=2
> 
> The OPP layer implementation expects to be used in multiple contexts
> (including calls from interrupt locked context) based on SOC framework 
> implementation. It is recommended to use appropriate locking schemes 
> within the SOC framework itself.

That should be stated directly in the kerneldoc comments.  The requirement
that the caller is supposed to ensure suitable locking is by no means
a trivial one.

Apart from this, it might be a good idea to help callers a bit and actually
introduce some sort of locking into the framework.

> In terms of the lifetime rules on the nodes in the list:
> The list is expected to be maintained once created, entries are expected 
> to be added optimally and not expected to be destroyed, the choice of 
> list implementation was for reducing the complexity of the code itself 
> and not yet meant as a mechanism to dynamically add and delete nodes on 
> the fly.. Essentially, it was intended for the SOC framework to ensure 
> it plugs in the OPP entries optimally and not create a humungous list of 
> all possible OPPs for all families of the vendor SOCs - even though it 
> is possible to use the OPP layer so - it just wont be smart to do so 
> considering list scan latencies on hot paths such as cpufreq transitions 
> or idle transitions.

If the list nodes are not supposed to be added and removed dynamically,
it probably would make sense to create data structures containing
the "available" OPPs only, once they are known, and simply free the object
representing the other ones.

Thanks,
Rafael
