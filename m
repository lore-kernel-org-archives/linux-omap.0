From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 12:19:58 -0700
Message-ID: <20100917121958.1dbb57af.akpm@linux-foundation.org>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
	<1284686973-13993-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1284686973-13993-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, Vishwanath BS <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pwsan.com>, Roberto
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Sep 2010 20:29:33 -0500
Nishanth Menon <nm@ti.com> wrote:

> SOCs have a standard set of tuples consisting of frequency and
> voltage pairs that the device will support per voltage domain.  These
> are called Operating Performance Points or OPPs. The actual
> definitions of Operating Performance Points varies over silicon within the
> same family of devices. For a specific domain, you can have a set of
> {frequency, voltage} pairs. As the kernel boots and more information
> is available, a set of these are activated based on the precise nature
> of device the kernel boots up on. It is interesting to remember that
> each IP which belongs to a voltage domain may define their own set of
> OPPs on top of this.
> 
> To implement an OPP, some sort of power management support is necessary
> hence this library enablement depends on CONFIG_PM, however this does
> not fit into the core power framework as it is an independent library.
> This is hence introduced under lib allowing all architectures to
> selectively enable the feature based on thier capabilities.
> 
> Contributions include:
> Sanjeev Premi for the initial concept:
> 	http://patchwork.kernel.org/patch/50998/
> Kevin Hilman for converting original design to device-based
> Kevin Hilman and Paul Walmsey for cleaning up many of the function
> abstractions, improvements and data structure handling
> Romit Dasgupta for using enums instead of opp pointers
> Thara Gopinath, Eduardo Valentin and Vishwanath BS for fixes and
> cleanups.
> Linus Walleij for recommending this layer be made generic for usage
> in other architectures beyond OMAP and ARM.
> 
> Discussions and comments from:
> http://marc.info/?l=linux-omap&m=126033945313269&w=2
> http://marc.info/?l=linux-omap&m=125482970102327&w=2
> http://marc.info/?t=125809247500002&r=1&w=2
> http://marc.info/?l=linux-omap&m=126025973426007&w=2
> http://marc.info/?t=128152609200064&r=1&w=2
> incorporated.
> 
> ...
>
>  Documentation/power/00-INDEX |    2 +
>  include/linux/opp.h          |  136 +++++++++++++
>  kernel/power/Kconfig         |   14 ++
>  lib/Makefile                 |    2 +
>  lib/opp.c                    |  440 ++++++++++++++++++++++++++++++++++++++++++

./lib/ is an unusual place to put a driver-like thing such as this. 
The lib/ directory is mainly for generic kernel-wide support things. 
I'd suggest that ./drivers/opp/ would be a better place.

>
> ...
>
> +/*
> + * Initialization wrapper used to define an OPP.
> + * To point at the end of a terminator of a list of OPPs,
> + * use OPP_DEF(0, 0, 0)
> + */
> +#define OPP_DEF(_enabled, _freq, _uv)	\
> +{						\
> +	.enabled	= _enabled,		\
> +	.freq		= _freq,		\
> +	.u_volt		= _uv,			\
> +}

OPP_DEF is a somewhat atypical name.  OPP_INITIALIZER would be more
conventional.

However OPP_DEF has no usage in this patch so perhaps this can be
removed?

> +static LIST_HEAD(dev_opp_list);

There's no locking for this list.  That's OK under some circumstances,
but I do think there should be a comment here explaining this apparent
bug: why is no locking needed, what are the lifetime rules for entries
on this list.

Also, the _ordering_ of items on this list is significant.  It should
also be documented.

>
> ...
>
> +/**
> + * opp_get_voltage() - Gets the voltage corresponding to an opp

Usually the () is omitted from function names in kerneldoc comments. 
It might be OK, or it might produce strange output - I haven't
checked.

>
> ...
>
> +/**
> + * opp_find_freq_exact() - search for an exact frequency
> + * @dev:	device for which we do this operation
> + * @freq:	frequency to search for
> + * @enabled:	enabled/disabled OPP to search for
> + *
> + * Searches for exact match in the opp list and returns handle to the matching

s/handle/pointer/

> + * opp if found, else returns ERR_PTR in case of error and should be handled
> + * using IS_ERR.
> + *
> + * Note: enabled is a modifier for the search. if enabled=true, then the match
> + * is for exact matching frequency and is enabled. if false, the match is for
> + * exact frequency which is disabled.
> + */
>
> ...
>
> +int opp_add(struct device *dev, const struct opp_def *opp_def)
> +{
> +	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
> +	struct opp *opp, *new_opp;
> +	struct list_head *head;
> +
> +	/* Check for existing list for 'dev' */
> +	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
> +		if (dev == tmp_dev_opp->dev) {
> +			dev_opp = tmp_dev_opp;
> +			break;
> +		}
> +	}
> +
> +	if (!dev_opp) {
> +		/* Allocate a new device OPP table */
> +		dev_opp = kzalloc(sizeof(struct device_opp), GFP_KERNEL);
> +		if (!dev_opp) {
> +			pr_warning("%s: unable to allocate device struct\n",
> +				__func__);
> +			return -ENOMEM;
> +		}
> +
> +		dev_opp->dev = dev;
> +		INIT_LIST_HEAD(&dev_opp->opp_list);
> +
> +		list_add(&dev_opp->node, &dev_opp_list);
> +	}
> +
> +	/* allocate new OPP node */
> +	new_opp = kzalloc(sizeof(struct opp), GFP_KERNEL);
> +	if (!new_opp) {
> +		if (list_empty(&dev_opp->opp_list)) {
> +			list_del(&dev_opp->node);

It would be neater to move the list_add() down to after the allocation
of new_opp and to remove this list_del().

> +			kfree(dev_opp);
> +		}
> +		pr_warning("%s: unable to allocate new opp node\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +	opp_populate(new_opp, opp_def);
> +
> +	/* Insert new OPP in order of increasing frequency */
> +	head = &dev_opp->opp_list;
> +	list_for_each_entry_reverse(opp, &dev_opp->opp_list, node) {
> +		if (new_opp->rate >= opp->rate) {
> +			head = &opp->node;
> +			break;
> +		}
> +	}
> +	list_add(&new_opp->node, head);
> +	dev_opp->opp_count++;
> +	if (new_opp->enabled)
> +		dev_opp->enabled_opp_count++;

These non-atomic read-modify-write operations on *dev_opp have no
locking.  What prevents races here?

> +	return 0;
> +}
> +
>
> ...
>
> +void opp_init_cpufreq_table(struct device *dev,
> +			    struct cpufreq_frequency_table **table)
> +{
> +	struct device_opp *dev_opp;
> +	struct opp *opp;
> +	struct cpufreq_frequency_table *freq_table;
> +	int i = 0;
> +
> +	dev_opp = find_device_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		pr_warning("%s: unable to find device\n", __func__);
> +		return;
> +	}
> +
> +	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
> +			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
> +	if (!freq_table) {
> +		pr_warning("%s: failed to allocate frequency table\n",
> +			   __func__);
> +		return;
> +	}
> +
> +	list_for_each_entry(opp, &dev_opp->opp_list, node) {
> +		if (opp->enabled) {
> +			freq_table[i].index = i;
> +			freq_table[i].frequency = opp->rate / 1000;
> +			i++;
> +		}
> +	}
> +
> +	freq_table[i].index = i;
> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	*table = &freq_table[0];
> +}

So we're playing with cpufreq internals here but there's no #ifdef
CONFIG_CPUFREQ and there's no Kconfig dependency on cpufreq.  That
needs fixing I think, if only from a reduce-code-bloat perspective.
