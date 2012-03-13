From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP3+: SmartReflex: introduce notifier_control
Date: Tue, 13 Mar 2012 12:40:01 -0500
Message-ID: <CAOMWX4fauZQccPhHn+f4-SOAXRbaU135xUKva0QsGgJoXDQzwA@mail.gmail.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
 <1331634381-31436-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1331634381-31436-4-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 13, 2012 at 05:26, <jean.pihet@newoldbits.com> wrote:
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c
> b/arch/arm/mach-omap2/smartreflex.c
> index 7977018..dfe8075 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
...
> + =A0 =A0 =A0 switch (sr->ip_type) {
> + =A0 =A0 =A0 case SR_TYPE_V1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D notifier_to_irqen_v1(sr_class->no=
tify_flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_modify_reg(sr, ERRCONFIG_V1, value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (enable) ? =
value : 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case SR_TYPE_V2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D notifier_to_irqen_v2(sr_class->no=
tify_flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_write_reg(sr, (enable) ? IRQENABLE_SET :=
 IRQENABLE_CLR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&sr->pdev->dev, "%s: unknown ty=
pe of sr??\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_write_reg(sr, IRQSTATUS, value);

can you move this to before we disable the interrupt? it took a while,
but we caught a bug recently when we disable IRQ and then attempt to
clear the status[1]

Regards,
Nishanth Menon
[1] http://review.omapzoom.org/#/c/20231/
