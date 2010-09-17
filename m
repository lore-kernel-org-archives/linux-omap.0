From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 16:23:26 -0500
Message-ID: <4C93DC4E.5020506@ti.com>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific
	OPPs>	<1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917121958.1dbb57af.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100917121958.1dbb57af.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pwsan.com>, Granados Dorado,
	Ro
List-Id: linux-omap@vger.kernel.org

Andrew Morton had written, on 09/17/2010 02:19 PM, the following:
> On Thu, 16 Sep 2010 20:29:33 -0500
> Nishanth Menon <nm@ti.com> wrote:
> 
[...]
>>
>>  Documentation/power/00-INDEX |    2 +
>>  include/linux/opp.h          |  136 +++++++++++++
>>  kernel/power/Kconfig         |   14 ++
>>  lib/Makefile                 |    2 +
>>  lib/opp.c                    |  440 ++++++++++++++++++++++++++++++++++++++++++
> 
> ./lib/ is an unusual place to put a driver-like thing such as this. 
> The lib/ directory is mainly for generic kernel-wide support things. 
> I'd suggest that ./drivers/opp/ would be a better place.
we had an interesting debate on this topic on the the thread starting
http://marc.info/?l=linux-arm-kernel&m=128465710624421&w=2

It really does not provide any driver like feature here. it is just a 
bunch of helper functions which any SOC framework can use to build up to 
implement either:
a) cpufreq implementation with various OPPs
b) bootup in a specific opp in a set of supported OPPs and stay there 
(e.g. mpurate support on OMAP platforms)

I had considered putting it in drivers/power, but it looks to contain 
mostly regulator stuff, the other alternative would be to include it in 
kernel/power or as Kevin H, Linus W and you mention drivers/opp

Personally, I dont have a strong feeling about it as long as it is 
reusable across SOCs and am hoping to hear some alignment :).

> 
>> ...
>>
>> +/*
>> + * Initialization wrapper used to define an OPP.
>> + * To point at the end of a terminator of a list of OPPs,
>> + * use OPP_DEF(0, 0, 0)
>> + */
>> +#define OPP_DEF(_enabled, _freq, _uv)	\
>> +{						\
>> +	.enabled	= _enabled,		\
>> +	.freq		= _freq,		\
>> +	.u_volt		= _uv,			\
>> +}
> 
> OPP_DEF is a somewhat atypical name.  OPP_INITIALIZER would be more
> conventional.
Thanks. will incorporate this in v2 of my patchset.

> 
> However OPP_DEF has no usage in this patch so perhaps this can be
> removed?
there were a few OMAP followon patches from
http://marc.info/?l=linux-omap&m=128152135801634&w=2
which will actually use this for OMAP3 platform.

> 
>> +static LIST_HEAD(dev_opp_list);
> 
> There's no locking for this list.  That's OK under some circumstances,
> but I do think there should be a comment here explaining this apparent
> bug: why is no locking needed, what are the lifetime rules for entries
> on this list.
Locking:
arrgh.. my bad.. I had documented it in the missing and later on posted 
opp.txt http://marc.info/?l=linux-arm-kernel&m=128473931626114&w=2

The OPP layer implementation expects to be used in multiple contexts
(including calls from interrupt locked context) based on SOC framework 
implementation. It is recommended to use appropriate locking schemes 
within the SOC framework itself.

In terms of the lifetime rules on the nodes in the list:
The list is expected to be maintained once created, entries are expected 
to be added optimally and not expected to be destroyed, the choice of 
list implementation was for reducing the complexity of the code itself 
and not yet meant as a mechanism to dynamically add and delete nodes on 
the fly.. Essentially, it was intended for the SOC framework to ensure 
it plugs in the OPP entries optimally and not create a humungous list of 
all possible OPPs for all families of the vendor SOCs - even though it 
is possible to use the OPP layer so - it just wont be smart to do so 
considering list scan latencies on hot paths such as cpufreq transitions 
or idle transitions.

I should add comments to the effect of the same to the list header and 
documentation - will do this as part of v2.
> 
> Also, the _ordering_ of items on this list is significant.  It should
> also be documented.
Ack. thanks for catching this. Will do it in v2.
> 
>> ...
>>
>> +/**
>> + * opp_get_voltage() - Gets the voltage corresponding to an opp
> 
> Usually the () is omitted from function names in kerneldoc comments. 
> It might be OK, or it might produce strange output - I haven't
> checked.
> 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/kernel-doc-nano-HOWTO.txt;h=3d8a97747f7731c801ca7d3a1483858feeb76b6c;hb=HEAD#l55
I wonder why the example protos use ()

>> ...
>>
>> +/**
>> + * opp_find_freq_exact() - search for an exact frequency
>> + * @dev:	device for which we do this operation
>> + * @freq:	frequency to search for
>> + * @enabled:	enabled/disabled OPP to search for
>> + *
>> + * Searches for exact match in the opp list and returns handle to the matching
> 
> s/handle/pointer/
Thanks.. will fix in v2.

> 
>> + * opp if found, else returns ERR_PTR in case of error and should be handled
>> + * using IS_ERR.
>> + *
>> + * Note: enabled is a modifier for the search. if enabled=true, then the match
>> + * is for exact matching frequency and is enabled. if false, the match is for
>> + * exact frequency which is disabled.
>> + */
>>
>> ...
>>
>> +int opp_add(struct device *dev, const struct opp_def *opp_def)
>> +{
>> +	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
>> +	struct opp *opp, *new_opp;
>> +	struct list_head *head;
>> +
>> +	/* Check for existing list for 'dev' */
>> +	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
>> +		if (dev == tmp_dev_opp->dev) {
>> +			dev_opp = tmp_dev_opp;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!dev_opp) {
>> +		/* Allocate a new device OPP table */
>> +		dev_opp = kzalloc(sizeof(struct device_opp), GFP_KERNEL);
>> +		if (!dev_opp) {
>> +			pr_warning("%s: unable to allocate device struct\n",
>> +				__func__);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		dev_opp->dev = dev;
>> +		INIT_LIST_HEAD(&dev_opp->opp_list);
>> +
>> +		list_add(&dev_opp->node, &dev_opp_list);
>> +	}
>> +
>> +	/* allocate new OPP node */
>> +	new_opp = kzalloc(sizeof(struct opp), GFP_KERNEL);
>> +	if (!new_opp) {
>> +		if (list_empty(&dev_opp->opp_list)) {
>> +			list_del(&dev_opp->node);
> 
> It would be neater to move the list_add() down to after the allocation
> of new_opp and to remove this list_del().
ack. thanks.. yes it does clean it up. additionally i expanded  the 
static opp_populate which is used just once - removed one function call ;)

> 
>> +			kfree(dev_opp);
>> +		}
>> +		pr_warning("%s: unable to allocate new opp node\n",
>> +			__func__);
>> +		return -ENOMEM;
>> +	}
>> +	opp_populate(new_opp, opp_def);
         ^^^^^^^^^^^^
>> +
>> +	/* Insert new OPP in order of increasing frequency */
>> +	head = &dev_opp->opp_list;
>> +	list_for_each_entry_reverse(opp, &dev_opp->opp_list, node) {
>> +		if (new_opp->rate >= opp->rate) {
>> +			head = &opp->node;
>> +			break;
>> +		}
>> +	}
>> +	list_add(&new_opp->node, head);
>> +	dev_opp->opp_count++;
>> +	if (new_opp->enabled)
>> +		dev_opp->enabled_opp_count++;
> 
> These non-atomic read-modify-write operations on *dev_opp have no
> locking.  What prevents races here?
explained above. it is the job of the framework using the OPP Layer library.

> 
>> +	return 0;
>> +}
>> +
>>
>> ...
>>
>> +void opp_init_cpufreq_table(struct device *dev,
>> +			    struct cpufreq_frequency_table **table)
>> +{
>> +	struct device_opp *dev_opp;
>> +	struct opp *opp;
>> +	struct cpufreq_frequency_table *freq_table;
>> +	int i = 0;
>> +
>> +	dev_opp = find_device_opp(dev);
>> +	if (IS_ERR(dev_opp)) {
>> +		pr_warning("%s: unable to find device\n", __func__);
>> +		return;
>> +	}
>> +
>> +	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
>> +			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
>> +	if (!freq_table) {
>> +		pr_warning("%s: failed to allocate frequency table\n",
>> +			   __func__);
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry(opp, &dev_opp->opp_list, node) {
>> +		if (opp->enabled) {
>> +			freq_table[i].index = i;
>> +			freq_table[i].frequency = opp->rate / 1000;
>> +			i++;
>> +		}
>> +	}
>> +
>> +	freq_table[i].index = i;
>> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +	*table = &freq_table[0];
>> +}
> 
> So we're playing with cpufreq internals here but there's no #ifdef
> CONFIG_CPUFREQ and there's no Kconfig dependency on cpufreq.  That
> needs fixing I think, if only from a reduce-code-bloat perspective.
Thanks and ouch.. Again missing documentation. Apologies.
http://marc.info/?l=linux-arm-kernel&m=128473931626114&w=2
c) Dependency of OPP layer is on CONFIG_PM as certain SOCs such as Texas
Instrument's OMAP support have frameworks to optionally boot at a 
certain opp without needing cpufreq.

This is called "mpurate" bootarg parameter in OMAP framework. I will put 
this under #ifdef CPUFREQ and provide header coverage for the same 
appropriately.

-- 
Regards,
Nishanth Menon
