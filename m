From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
Date: Wed, 12 Sep 2018 10:09:15 -0700
Message-ID: <20180912170915.GK5662@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180910200624.4494-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180910 20:10]:
> +static void __maybe_unused
> +omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
> +{
> +	/* Restore level registers after idle */
> +	writel_relaxed(bank->context.leveldetect0,
> +		       bank->base + bank->regs->leveldetect0);
> +	writel_relaxed(bank->context.leveldetect1,
> +		       bank->base + bank->regs->leveldetect1);
> +
> +	/* Clear wake after idle */
> +	writel_relaxed(0, bank->base + bank->regs->wkup_en);

	/* Reset saved wkup_en, it will be set for next idle again */
	bank->context.wake_en = 0;
> +}

Clearing the saved wkup_en is needed above I noticed
testing again with gpio4 which has pdata->loses_context
set.

Otherwise runtime_resume will write to wkup_en enabling
it for runtime which will the next idle fail.

Regards,

Tony
