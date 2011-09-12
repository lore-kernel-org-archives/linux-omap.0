From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Mon, 12 Sep 2011 14:06:55 -0700
Message-ID: <87y5xteahc.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:15 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
> retention (CSWR) is not supported by hardware design.
>
> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>
> CPUx sleep code is common for hotplug, suspend and CPUilde.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

> @@ -38,6 +39,11 @@ void __iomem *omap4_get_scu_base(void)
>  
>  void __cpuinit platform_secondary_init(unsigned int cpu)
>  {
> +	/* Enable NS access to SMP bit for this CPU on EMU/HS devices */
> +	if (cpu_is_omap443x() && (omap_type() != OMAP2_DEVICE_TYPE_GP))

A comment here about why this is 443x specific would be helpful.

I see a comment in omap4_cpu_resume() that seems to indicate that SMP
bit is accessible on 446x NS devices, but repeating that commen here
would help future readability.

Kevin
