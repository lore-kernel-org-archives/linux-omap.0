From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap2: clockdomain: Inroduce cpu_pm notifiers for
 context save/restore
Date: Thu, 17 May 2018 14:43:47 -0700
Message-ID: <20180517214347.GR98604@atomide.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180516 15:21]:
> Inroduce cpu_pm notifiers for context save/restore. This will be
> needed for am43xx family in case of rtc only mode with ddr in
> self-refresh.
...
> +static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
> +{
> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		if (enable_off_mode)
> +			clkdm_save_context();
> +		break;
> +	case CPU_CLUSTER_PM_EXIT:
> +		if (enable_off_mode)
> +			clkdm_restore_context();
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

Can you do this too only on suspend instead of the cpu notifier?
If you need to call this eventually from cpuidle also then yeah
the notifier makes sense.

Regards,

Tony
