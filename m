From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Fri, 17 Sep 2010 15:51:58 -0700
Message-ID: <878w30ugoh.fsf@deeprootsystems.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917121958.1dbb57af.akpm@linux-foundation.org>
	<4C93DC4E.5020506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C93DC4E.5020506@ti.com> (Nishanth Menon's message of "Fri, 17
	Sep 2010 16:23:26 -0500")
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

Nishanth Menon <nm@ti.com> writes:

> Andrew Morton had written, on 09/17/2010 02:19 PM, the following:
>> On Thu, 16 Sep 2010 20:29:33 -0500
>> Nishanth Menon <nm@ti.com> wrote:
>>

[...]

>>> +void opp_init_cpufreq_table(struct device *dev,
>>> +			    struct cpufreq_frequency_table **table)
>>> +{
>>> +	struct device_opp *dev_opp;
>>> +	struct opp *opp;
>>> +	struct cpufreq_frequency_table *freq_table;
>>> +	int i = 0;
>>> +
>>> +	dev_opp = find_device_opp(dev);
>>> +	if (IS_ERR(dev_opp)) {
>>> +		pr_warning("%s: unable to find device\n", __func__);
>>> +		return;
>>> +	}
>>> +
>>> +	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
>>> +			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
>>> +	if (!freq_table) {
>>> +		pr_warning("%s: failed to allocate frequency table\n",
>>> +			   __func__);
>>> +		return;
>>> +	}
>>> +
>>> +	list_for_each_entry(opp, &dev_opp->opp_list, node) {
>>> +		if (opp->enabled) {
>>> +			freq_table[i].index = i;
>>> +			freq_table[i].frequency = opp->rate / 1000;
>>> +			i++;
>>> +		}
>>> +	}
>>> +
>>> +	freq_table[i].index = i;
>>> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
>>> +
>>> +	*table = &freq_table[0];
>>> +}
>>
>> So we're playing with cpufreq internals here but there's no #ifdef
>> CONFIG_CPUFREQ and there's no Kconfig dependency on cpufreq.  That
>> needs fixing I think, if only from a reduce-code-bloat perspective.
>
> Thanks and ouch.. Again missing documentation. Apologies.
> http://marc.info/?l=linux-arm-kernel&m=128473931626114&w=2
>
> c) Dependency of OPP layer is on CONFIG_PM as certain SOCs such as Texas
> Instrument's OMAP support have frameworks to optionally boot at a
> certain opp without needing cpufreq.
>
> This is called "mpurate" bootarg parameter in OMAP framework. I will
> put this under #ifdef CPUFREQ and provide header coverage for the same
> appropriately.

The OPP layer in general is dependent on CONFIG_PM, but the snippit
above is called only by CPUfreq core when CPUfreq is enabled, so at
least that function should be under #ifdef CPUFREQ.

Kevin
