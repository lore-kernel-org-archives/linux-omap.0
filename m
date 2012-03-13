From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v2 5/5] ARM: OMAP2+: clean up some cppcheck warnings
Date: Tue, 13 Mar 2012 13:51:41 +0530
Message-ID: <CA+HSevoVd-pU968DxMsYtHw58gUid9pAyY8gp1u1NdOc3orTzA@mail.gmail.com>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224257.4103.11096.stgit@dusk>
 <alpine.DEB.2.00.1203130211300.22211@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1203130211300.22211@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 13, 2012 at 13:42, Paul Walmsley <paul@pwsan.com> wrote:
>
>
> Resolve some warnings identified by cppcheck in arch/arm/mach-omap2:
>
> =A0 =A0[arch/arm/mach-omap2/usb-tusb6010.c:129]: (style) Checking if unsi=
gned
> variable 'tmp' is less than zero.
> =A0 =A0[arch/arm/mach-omap2/prm_common.c:241]: (error) Possible null poin=
ter
> dereference: irq_setup - otherwise it is redundant to check if irq_setup =
is
> null at line 247
> =A0 =A0[arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'per_clkdm' is
> assigned a value that is never used
> =A0 =A0[arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'core_clkdm' =
is
> assigned a value that is never used
> =A0 =A0[arch/arm/mach-omap2/pm24xx.c:185]: (style) Variable 'only_idle' is
> assigned a value that is never used
> =A0 =A0[arch/arm/mach-omap2/mux.c:254]: (error) Possible null pointer
> dereference: mux
> =A0 =A0[arch/arm/mach-omap2/mux.c:258]: (error) Possible null pointer
> dereference: mux
> =A0 =A0[arch/arm/mach-omap2/gpmc-onenand.c:178]: (style) Variable 'tick_n=
s' is
> assigned a value that is never used
> =A0 =A0[arch/arm/mach-omap2/gpio.c:56]: (error) Possible null pointer
> dereference: pdata - otherwise it is redundant to check if pdata is null =
at
> line 57
> =A0 =A0[arch/arm/mach-omap2/devices.c:45]: (style) Variable 'l' is assign=
ed a
> value that is never used
> =A0 =A0[arch/arm/mach-omap2/board-am3517evm.c:134]: (style) Variable 'reg=
val'
> is assigned a value that is never used
>
> Some of them are pretty good catches, such the gpio.c:56 and
> usb-tusb6010.c:129.
>
> Thanks to Jarkko Nikula for some comments on the sscanf() warnings.
> It seems that the kernel sscanf() ignores the field width anyway for the
> %d format, so those changes have been dropped from this second version.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Charulatha Varadarajan <charu@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-am3517evm.c | =A0 =A06 +-----
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0| =A0 =A08 ++++----
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0 =A03 +--
> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/gpmc-onenand.c =A0 =A0| =A0 =A03 +--
> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A03 ---
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 +---
> =A0arch/arm/mach-omap2/prm_common.c =A0 =A0 =A0| =A0 =A04 +++-
> =A0arch/arm/mach-omap2/usb-tusb6010.c =A0 =A0| =A0 =A02 +-
> =A010 files changed, 14 insertions(+), 23 deletions(-)
>

[snip]

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 8cbfbc2..2803ff8 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -54,7 +54,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh,
> void *unused)
> =A0 =A0 =A0 =A0pdata->virtual_irq_start =3D IH_GPIO_BASE + 32 * (id - 1);
>
> =A0 =A0 =A0 =A0pdata->regs =3D kzalloc(sizeof(struct omap_gpio_reg_offs),
> GFP_KERNEL);
> - =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 if (!pdata->regs) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("gpio%d: Memory allocation failed\n=
", id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}

Reviewed-by: Charulatha Varadarajan <charu@ti.com>
