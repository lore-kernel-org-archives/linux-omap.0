From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3] power: introduce library for device-specific OPPs
Date: Wed, 22 Sep 2010 19:29:56 -0500
Message-ID: <4C9A9F84.7000104@ti.com>
References: <[PATCH] opp: introduce library for device-specific OPPs>
	<1285192054-454-1-git-send-email-nm@ti.com>
	<201009230203.09230.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201009230203.09230.rjw@sisk.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Rafael J. Wysocki had written, on 09/22/2010 07:03 PM, the following:
> [Trimming the CC list slightly.]
[...]

> ...
> 
> First, thanks for addressing the previous comments, things look much better
> now.  In particular the documentation has been improved a lot in my view.
Thanks for the excellent reviews :)

[...]

>> +
>> +WARNING on OPP List Modification Vs Query operations:
>> +----------------------------------------------------
>> +The OPP layer's query functions are expected to be used in multiple contexts
>> +(including calls from interrupt locked context) based on SoC framework
>> +implementation. Only OPP modification functions are guaranteed exclusivity by
>> +the OPP library. Exclusivity between query functions and modification functions
>> +should be handled by the users such as the SoC framework appropriately; else,
>> +there is a risk for the query functions to retrieve stale data.
> 
> Well, this sounds like a good use case for RCU.
Kevin did point out rwlock but am I confusing with
http://lwn.net/Articles/364583/
If I get the message right, rwlock is more or less on it's way out?

[...]

>> +static struct device_opp *find_device_opp(struct device *dev)
>> +{
>> +     struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
>> +
>> +     if (unlikely(!dev || IS_ERR(dev))) {
>> +             pr_err("%s: Invalid parameters being passed\n", __func__);
>> +             return ERR_PTR(-EINVAL);
>> +     }
>> +
>> +     list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
>> +             if (tmp_dev_opp->dev == dev) {
>> +                     dev_opp = tmp_dev_opp;
>> +                     break;
>> +             }
>> +     }
> 
> As I said, it seems you can use RCU read locking around the list traversal
> to protect it from concurrent modification.
> 
>> +     return dev_opp;
>> +}
>> +
[...]

>> +struct opp *opp_find_freq_exact(struct device *dev,
>> +                                  unsigned long freq, bool available)
>> +{
>> +     struct device_opp *dev_opp;
>> +     struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
>> +
>> +     dev_opp = find_device_opp(dev);
>> +     if (IS_ERR(dev_opp))
>> +             return opp;
>> +
>> +     list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
>> +             if (temp_opp->available == available &&
>> +                             temp_opp->rate == freq) {
>> +                     opp = temp_opp;
>> +                     break;
>> +             }
>> +     }
>> +
> 
> Same here.
> 
>> +     return opp;
>> +}
>> +
>> +/**
>> + * opp_find_freq_ceil() - Search for an rounded ceil freq
>> + * @dev:     device for which we do this operation
>> + * @freq:    Start frequency
>> + *
>> + * Search for the matching ceil *available* OPP from a starting freq
>> + * for a device.
>> + *
>> + * Returns matching *opp and refreshes *freq accordingly, else returns
>> + * ERR_PTR in case of error and should be handled using IS_ERR.
>> + *
>> + * Example usages:
>> + *   * find match/next highest available frequency *
>> + *   freq = 350000;
>> + *   opp = opp_find_freq_ceil(dev, &freq))
>> + *   if (IS_ERR(opp))
>> + *           pr_err("unable to find a higher frequency\n");
>> + *   else
>> + *           pr_info("match freq = %ld\n", freq);
>> + *
>> + *   * print all supported frequencies in ascending order *
>> + *   freq = 0; * Search for the lowest available frequency *
>> + *   while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq)) {
>> + *           pr_info("freq = %ld\n", freq);
>> + *           freq++; * for next higher match *
>> + *   }
> 
> I think it's sufficient to put the examples into the doc (the ones below too).
> 
Ack. thanks for pointing it out.. will fix in v4.

>> +     freq_table[i].index = i;
>> +     freq_table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +     *table = &freq_table[0];
>> +}
>> +#endif               /* CONFIG_CPU_FREQ */
> 
> The rest looks fine to me.
thx.

-- 
Regards,
Nishanth Menon
