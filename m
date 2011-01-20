From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH] ARM: oprofile: Always allow backtraces
Date: Thu, 20 Jan 2011 10:02:30 -0000
Message-ID: <19819.4611505189$1295517917@news.gmane.org>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
	<000101cbb886$582f1480$088d3d80$@deacon@arm.com>
	<20110120095239.GT21401@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110120095239.GT21401@erda.amd.com>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Robert Richter' <robert.richter@amd.com>
Cc: 'Ari Kauppi' <kauppi@papupata.org>, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, Matt Fleming <matt@console-pimps.org>
List-Id: linux-omap@vger.kernel.org

Hi Robert,

> I would like to go even further, see the diff below.

[...]
 
> +#else
> +
> +static int oprofile_arch_init(struct oprofile_operations *ops)
> +{
> +	pr_info("oprofile: hardware counters not available\n");
> +	return -ENODEV;
> +}
> +
> +static void oprofile_arch_exit(void) { }
> +
> +#endif /* CONFIG_HW_PERF_EVENTS */

Don't we now have oprofile_arch_init defined twice in the non-PMU 
case? (and one of these definitions is __init)?

>  static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
>  {
>  	struct frame_tail *tail = ((struct frame_tail *) regs->ARM_fp) - 1;
> @@ -111,6 +123,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
> 
>  int __init oprofile_arch_init(struct oprofile_operations *ops)
>  {
> +	/* provide backtrace support also in timer mode: */
>  	ops->backtrace		= arm_backtrace;

Right, so this becomes common code but we need to ensure that we
don't call oprofile_perf_init. I suppose an alternative would be
to provide an empty static inline stub for oprofile_perf_init
instead.

Will
