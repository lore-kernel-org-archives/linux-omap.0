From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 1/2] power: bq24190_charger: Check the interrupt status on resume
Date: Thu, 2 Feb 2017 16:32:50 -0800
Message-ID: <CAKvHMgQ4TCu28Bb8aG-mEQKN4DqQ13E57Une=Xjo3STZS_rzOg@mail.gmail.com>
References: <20170131000210.5442-1-tony@atomide.com> <20170131000210.5442-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170131000210.5442-2-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2017 at 4:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> Some SoCs like omap3 can configure GPIO irqs to use Linux generic
> dedicated wakeirq support. If the dedicated wakeirq is configured,
> the SoC will use a always-on interrupt controller to produce wake-up
> events.
>
> If bq24190 is configured for dedicated wakeirq, we need to check the
> interrupt status on PM runtime resume. This is because the Linux
> generic wakeirq will call pm_runtime_resume() on the device on a
> wakeirq. And as the bq24190 interrupt is falling edge sensitive
> and only active for 250 us, there will be no device interrupt seen
> by the runtime SoC IRQ controller.
>
> Note that this can cause spurious interrupts on omap3 devices with
> bq24190 connected to gpio banks 2 - 5 as there's a glitch on those
> pins waking from off mode as listed in "Advisory 1.45". Devices
> with this issue should not configure the optional wakeirq interrupt
> in the dts file.
>
> Cc: Liam Breck <kernel@networkimprov.net>
> Acked-by: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 62 ++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> ...
> @@ -1472,7 +1510,11 @@ static int bq24190_pm_resume(struct device *dev)
>  }
>  #endif
>
> -static SIMPLE_DEV_PM_OPS(bq24190_pm_ops, bq24190_pm_suspend, bq24190_pm_resume);
> +static const struct dev_pm_ops bq24190_pm_ops = {
> +       SET_RUNTIME_PM_OPS(bq24190_runtime_suspend, bq24190_runtime_resume,
> +                          NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(bq24190_pm_suspend, bq24190_pm_resume)

Can delete newline before NULL) here, if so inclined :-)

Acked-by: Liam Breck <kernel@networkimprov.net>
