From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] omap2: powerdomain: Inroduce cpu_pm notifiers for
 context save/restore
Date: Thu, 17 May 2018 14:45:07 -0700
Message-ID: <20180517214507.GS98604@atomide.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1526483821-25585-5-git-send-email-j-keerthy@ti.com>
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
> +	/* Only AM43XX can lose pwrdm context during rtc-ddr suspend */
> +	if (soc_is_am43xx()) {
> +		nb.notifier_call = cpu_notifier;
> +		cpu_pm_register_notifier(&nb);
> +	}
> +

Hmm in patch 3/4 you add omap4_pwrdm_save_context(), I think
that we'd want to run with the notifier for cpuidle on omap4?

Regards,

Tony
