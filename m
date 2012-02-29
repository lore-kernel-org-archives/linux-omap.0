From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v6 5/9] ARM: davinci: Consolidate time keeping and irq enable
Date: Wed, 29 Feb 2012 09:36:56 +0100
Message-ID: <CAORVsuUyOz3ZDr7iR50Qi-TiT+Ng_fUBJGJU19JpQsfe6ZpwHw@mail.gmail.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
	<1330485109-7327-6-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330485109-7327-6-git-send-email-rob.lee@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Rob,

On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0arch/arm/mach-davinci/cpuidle.c | =A0 78 +++++++++++++++----------=
-------------
> =A01 files changed, 31 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/=
cpuidle.c
> index a30c7c5..6f457f1 100644
> --- a/arch/arm/mach-davinci/cpuidle.c
> +++ b/arch/arm/mach-davinci/cpuidle.c
=2E..

> @@ -30,12 +31,42 @@ struct davinci_ops {
> =A0 =A0 =A0 =A0u32 flags;
> =A0};
>
> +/* Actual code that puts the SoC in different idle states */
> +static int davinci_enter_idle(struct cpuidle_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
cpuidle_driver *drv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int index)
> +{
> + =A0 =A0 =A0 struct cpuidle_state_usage *state_usage =3D &dev->state=
s_usage[index];
> + =A0 =A0 =A0 struct davinci_ops *ops =3D cpuidle_get_statedata(state=
_usage);
> +
> + =A0 =A0 =A0 if (ops && ops->enter)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->enter(ops->flags);
> +
> + =A0 =A0 =A0 return cpuidle_wrap_enter(dev, =A0drv, index,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle=
_simple_enter);
This does not look right since ops->exit will never be called.

> +
> + =A0 =A0 =A0 if (ops && ops->exit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->exit(ops->flags);
> +
> + =A0 =A0 =A0 return index;
> +}
> +
=2E..

Regards,
Jean
