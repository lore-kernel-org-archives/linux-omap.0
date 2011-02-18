From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH] OMAP4:Fix -EINVAL for vana, vcxio, vdac
Date: Fri, 18 Feb 2011 10:48:17 +0530
Message-ID: <AANLkTinaueC5dizcKXJ-eEjwA1HpLCaYX8Mv6NA9PMC1@mail.gmail.com>
References: <1297092599-428-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1297092599-428-1-git-send-email-balajitk@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 7, 2011 at 8:59 PM, Balaji T K <balajitk@ti.com> wrote:
> Fixed regulators in twl6030 do not have set_voltage hook.
> Regulator core returns -22 if set_voltage is NULL and apply_uV is set
> while applying the constraint to set voltage resulting in failure during =
probe
> of these regulators.
> Do not set apply_uV for fixed regulators which don't have set_voltage.

Hi Tony,

Any comments on this patch.
If not can you queue this.

>
> machine_constraints_voltage: VANA: failed to apply 2100000uV constraint
> twl_reg twl_reg.43: can't register VANA, -22
> twl_reg: probe of twl_reg.43 failed with error -22
> machine_constraints_voltage: VCXIO: failed to apply 1800000uV constraint
> twl_reg twl_reg.44: can't register VCXIO, -22
> twl_reg: probe of twl_reg.44 failed with error -22
> machine_constraints_voltage: VDAC: failed to apply 1800000uV constraint
> twl_reg twl_reg.45: can't register VDAC, -22
> twl_reg: probe of twl_reg.45 failed with error -22
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> Boot tested on OMAP4SDP with omap2plus_defconfig
>
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0| =A0 =A03 ---
> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A03 ---
> =A02 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/bo=
ard-4430sdp.c
> index 07d1b20..1b16525 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -434,7 +434,6 @@ static struct regulator_init_data sdp4430_vana =3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 2100000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 2100000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D t=
rue,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANGE_MO=
DE
> @@ -446,7 +445,6 @@ static struct regulator_init_data sdp4430_vcxio =3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D t=
rue,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANGE_MO=
DE
> @@ -458,7 +456,6 @@ static struct regulator_init_data sdp4430_vdac =3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D t=
rue,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANGE_MO=
DE
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2=
/board-omap4panda.c
> index e001a04..3686533 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -305,7 +305,6 @@ static struct regulator_init_data omap4_panda_vana =
=3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 2100000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 2100000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D t=
rue,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANGE_MO=
DE
> @@ -317,7 +316,6 @@ static struct regulator_init_data omap4_panda_vcxio =
=3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D t=
rue,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANGE_MO=
DE
> @@ -329,7 +327,6 @@ static struct regulator_init_data omap4_panda_vdac =
=3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1800000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D t=
rue,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANGE_MO=
DE
> --
> 1.7.0.4
>
>
