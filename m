From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH V3 05/19] OMAP3+: voltage: use IS_ERR_OR_NULL
Date: Sat, 5 Mar 2011 19:36:04 +0200
Message-ID: <AANLkTi=q_ASfvLbZv=D8p3XvuMX8ek3hcEHU5wtfkm7J@mail.gmail.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51154 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab1CERgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 12:36:06 -0500
Received: by wwb22 with SMTP id 22so3753027wwb.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 09:36:04 -0800 (PST)
In-Reply-To: <1299338962-5602-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Hi Nishanth,

On Sat, Mar 5, 2011 at 5:29 PM, Nishanth Menon <nm@ti.com> wrote:
> Use IS_ERR_OR_NULL macro instead of !xyz || IS_ERR(xyz) usage.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =C2=A0arch/arm/mach-omap2/voltage.c | =C2=A0 22 +++++++++++----------=
-
> =C2=A01 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 53c399f..76bcaee 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -682,7 +682,7 @@ unsigned long omap_voltage_get_nom_volt(struct vo=
ltagedomain *voltdm)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {

I have one comment here. voltdm is received as parameter and it's
already checked by IS_ERR(). Is there any specific reason for that?
IS_ERR() doesn't suppose to be a macro to check if the pointer is
valid or not, but to know if there's an invalid value with error code
in the pointer value. It's useful when you have a function which
returns a pointer but it can return an error code when it fails.
Please, note that IS_ERR() won't detect invalid pointers which does
not represent an error code, so it's not correct to rely on it for
this purpose.
IMO, instead of change to IS_ERR_OR_NULL(), you could only remove
IS_ERR(). The same apply for the other cases.

Kind regards,

David Cohen

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -703,7 +703,7 @@ unsigned long omap_vp_get_curr_volt(struct voltag=
edomain *voltdm)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 curr_vsel;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -738,7 +738,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vpconfig;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -776,7 +776,7 @@ void omap_vp_disable(struct voltagedomain *voltdm=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vpconfig;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int timeout;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -829,7 +829,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *=
voltdm,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -858,7 +858,7 @@ void omap_voltage_reset(struct voltagedomain *vol=
tdm)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long target_uvdc;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -890,7 +890,7 @@ void omap_voltage_get_volttable(struct voltagedom=
ain *voltdm,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -921,7 +921,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(=
struct voltagedomain *voltdm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR=
(-EINVAL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -959,7 +959,7 @@ int omap_voltage_register_pmic(struct voltagedoma=
in *voltdm,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -986,7 +986,7 @@ struct dentry *omap_voltage_get_dbgdir(struct vol=
tagedomain *voltdm)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -1011,7 +1011,7 @@ void omap_change_voltscale_method(struct voltag=
edomain *voltdm,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!voltdm || IS_ERR(voltdm)) {
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(voltdm)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("%s=
: VDD specified does not exist!\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
