From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 09/12] OMAP: VP: Explicitly mask VPVOLTAGE field
Date: Wed, 7 Sep 2011 14:31:32 +0200
Message-ID: <CAORVsuVmNa_15X4okj0mgCx=MHNPo+8zxNO03j7aKSS+t7yD-Q@mail.gmail.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
	<1314640692-3386-10-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314640692-3386-10-git-send-email-khilman@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Kevin,

On Mon, Aug 29, 2011 at 7:58 PM, Kevin Hilman <khilman@ti.com> wrote:
> From: Todd Poynor <toddpoynor@google.com>
>
> Reading the VPVOLTAGE field of PRM_VP_*_VOLTAGE registers currently
> relies on a u32 -> u8 conversion to mask off the FORCEUPDATEWAIT field
> in the upper bits. =A0Make this explicit using the mask symbol
> already defined, added as a new field in struct omap_vp_common.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 =A0 =A0| =A0 =A03 ++-
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/vp3xxx_data.c | =A0 =A02 ++
> =A0arch/arm/mach-omap2/vp44xx_data.c | =A0 =A01 +
> =A04 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index e7d38f6..3807620 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -227,7 +227,8 @@ unsigned long omap_vp_get_curr_volt(struct voltagedom=
ain *voltdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 curr_vsel =3D voltdm->read(vp->voltage);
> + =A0 =A0 =A0 curr_vsel =3D (voltdm->read(vp->voltage) & vp->common->vpvo=
ltage_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(vp->common->vpvoltage_mask);
>From the commit description it is not clear how the behavior of
voltdm->read is changed. Is this part of another patch from this set?

>
> =A0 =A0 =A0 =A0if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: PMIC function to convert v=
sel to voltage"
> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
> index 0d63267..f78752b 100644
> --- a/arch/arm/mach-omap2/vp.h
> +++ b/arch/arm/mach-omap2/vp.h
> @@ -63,6 +63,7 @@ struct omap_vp_ops {
> =A0* @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
> =A0* @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
> =A0* @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
> + * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
> =A0*/
> =A0struct omap_vp_common {
> =A0 =A0 =A0 =A0u32 vpconfig_erroroffset_mask;
> @@ -79,6 +80,7 @@ struct omap_vp_common {
> =A0 =A0 =A0 =A0u8 vlimitto_vddmin_shift;
> =A0 =A0 =A0 =A0u8 vlimitto_vddmax_shift;
> =A0 =A0 =A0 =A0u8 vlimitto_timeout_shift;
> + =A0 =A0 =A0 u8 vpvoltage_mask;
>
> =A0 =A0 =A0 =A0const struct omap_vp_ops *ops;
> =A0};
> diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3x=
xx_data.c
> index d429c44..260c554 100644
> --- a/arch/arm/mach-omap2/vp3xxx_data.c
> +++ b/arch/arm/mach-omap2/vp3xxx_data.c
> @@ -51,6 +51,8 @@ static const struct omap_vp_common omap3_vp_common =3D {
> =A0 =A0 =A0 =A0.vlimitto_vddmin_shift =3D OMAP3430_VDDMIN_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_vddmax_shift =3D OMAP3430_VDDMAX_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_timeout_shift =3D OMAP3430_TIMEOUT_SHIFT,
> + =A0 =A0 =A0 .vpvoltage_mask =3D OMAP3430_VPVOLTAGE_MASK,
> +
Stray empty line...

> =A0 =A0 =A0 =A0.ops =3D &omap3_vp_ops,
> =A0};
>
> diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44=
xx_data.c
> index 0daf2a4..b4e7704 100644
> --- a/arch/arm/mach-omap2/vp44xx_data.c
> +++ b/arch/arm/mach-omap2/vp44xx_data.c
> @@ -51,6 +51,7 @@ static const struct omap_vp_common omap4_vp_common =3D {
> =A0 =A0 =A0 =A0.vlimitto_vddmin_shift =3D OMAP4430_VDDMIN_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_vddmax_shift =3D OMAP4430_VDDMAX_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_timeout_shift =3D OMAP4430_TIMEOUT_SHIFT,
> + =A0 =A0 =A0 .vpvoltage_mask =3D OMAP4430_VPVOLTAGE_MASK,
> =A0 =A0 =A0 =A0.ops =3D &omap4_vp_ops,
> =A0};
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Regards,
Jean
