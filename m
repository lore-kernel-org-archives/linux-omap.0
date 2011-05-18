From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 04/11] OMAP4: PM: VC: support
 configuration of i2c clks
Date: Wed, 18 May 2011 03:57:39 -0500
Message-ID: <BANLkTin5f5oz4aTiebmwWrwYCE2W2OLyAA@mail.gmail.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com> <1305695854-9638-5-git-send-email-nm@ti.com>
 <87y624xucx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37195 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755174Ab1ERI6A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:58:00 -0400
Received: by mail-ww0-f52.google.com with SMTP id 31so1757180wwb.9
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:57:59 -0700 (PDT)
In-Reply-To: <87y624xucx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 03:53, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> Patch "OMAP2+: voltage: split voltage controller (VC) code into dedi=
cated layer"
>> splits out the hardcoded value in the code to vc's channel init.
>>
>> This patch further isolates the configuration to remove out PMIC spe=
cific
>> configuration as high and low times are pmic specific.
>>
>> Values are updated as well based on latest TI analysis done in andro=
id k35
>> kernel.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> OK, this is a step in the right direction, but IIUC, these values are
> sys_clk dependent right? =A0Shouldn't we be calculating these values =
based
> on sys_clk?
3 factors to my knowledge:
a) sr clk I believe(I need to grab the relevant internal doc to
verify) - factor of sysclk - > board based/in a way pmic based
b)  factor of board capacitance (similar to i2c bus)
c)  i2c bus capability of the PMIC itself.

hence based it off pmic data..

Regards,
Nishanth Menon


>
> Kevin
>
>> ---
>> note: Generates two over 80 char warnings, left as is for maintainin=
g
>> code continuity.
>> WARNING: line over 80 characters
>> #71: FILE: arch/arm/mach-omap2/prm-regbits-44xx.h:1068:
>> +#define OMAP4430_HSCLH_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xff << 16)
>> =A0 =A0 =A0 WARNING: line over 80 characters
>> #75: FILE: arch/arm/mach-omap2/prm-regbits-44xx.h:1072:
>> =A0 =A0 =A0 +#define OMAP4430_HSCLL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xff << 24=
)
>>
>> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 | =A0 13 +++++++++=
++++
>> =A0arch/arm/mach-omap2/prm-regbits-44xx.h | =A0 =A08 ++++++++
>> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 16 +++=
+++++++++----
>> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0| =A0 =A08 +++++=
+++
>> =A04 files changed, 41 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/om=
ap_twl.c
>> index 30f4323..82a91be 100644
>> --- a/arch/arm/mach-omap2/omap_twl.c
>> +++ b/arch/arm/mach-omap2/omap_twl.c
>> @@ -202,6 +202,10 @@ static struct omap_voltdm_pmic omap4_mpu_pmic =3D=
 {
>> =A0 =A0 =A0 .i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_AD=
DR,
>> =A0 =A0 =A0 .volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_MPU_SR_V=
OLT_REG,
>> =A0 =A0 =A0 .i2c_high_speed =A0 =A0 =A0 =A0 =3D true,
>> + =A0 =A0 .i2c_scll_low =A0 =A0 =A0 =A0 =A0 =3D 0x28,
>> + =A0 =A0 .i2c_scll_high =A0 =A0 =A0 =A0 =A0=3D 0x2C,
>> + =A0 =A0 .i2c_hscll_low =A0 =A0 =A0 =A0 =A0=3D 0x0B,
>> + =A0 =A0 .i2c_hscll_high =A0 =A0 =A0 =A0 =3D 0x00,
>> =A0 =A0 =A0 .vsel_to_uv =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_vsel_to_=
uv,
>> =A0 =A0 =A0 .uv_to_vsel =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_uv_to_vs=
el,
>> =A0};
>> @@ -223,6 +227,10 @@ static struct omap_voltdm_pmic omap4_iva_pmic =3D=
 {
>> =A0 =A0 =A0 .i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_AD=
DR,
>> =A0 =A0 =A0 .volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_IVA_SR_V=
OLT_REG,
>> =A0 =A0 =A0 .i2c_high_speed =A0 =A0 =A0 =A0 =3D true,
>> + =A0 =A0 .i2c_scll_low =A0 =A0 =A0 =A0 =A0 =3D 0x28,
>> + =A0 =A0 .i2c_scll_high =A0 =A0 =A0 =A0 =A0=3D 0x2C,
>> + =A0 =A0 .i2c_hscll_low =A0 =A0 =A0 =A0 =A0=3D 0x0B,
>> + =A0 =A0 .i2c_hscll_high =A0 =A0 =A0 =A0 =3D 0x00,
>> =A0 =A0 =A0 .vsel_to_uv =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_vsel_to_=
uv,
>> =A0 =A0 =A0 .uv_to_vsel =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_uv_to_vs=
el,
>> =A0};
>> @@ -242,6 +250,11 @@ static struct omap_voltdm_pmic omap4_core_pmic =
=3D {
>> =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_CORE_=
VLIMITTO_VDDMAX,
>> =A0 =A0 =A0 .vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITTO_=
TIMEOUT_US,
>> =A0 =A0 =A0 .i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_AD=
DR,
>> + =A0 =A0 .i2c_high_speed =A0 =A0 =A0 =A0 =3D true,
>> + =A0 =A0 .i2c_scll_low =A0 =A0 =A0 =A0 =A0 =3D 0x28,
>> + =A0 =A0 .i2c_scll_high =A0 =A0 =A0 =A0 =A0=3D 0x2C,
>> + =A0 =A0 .i2c_hscll_low =A0 =A0 =A0 =A0 =A0=3D 0x0B,
>> + =A0 =A0 .i2c_hscll_high =A0 =A0 =A0 =A0 =3D 0x00,
>> =A0 =A0 =A0 .volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_CORE_SR_=
VOLT_REG,
>> =A0 =A0 =A0 .vsel_to_uv =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_vsel_to_=
uv,
>> =A0 =A0 =A0 .uv_to_vsel =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_uv_to_vs=
el,
>> diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-=
omap2/prm-regbits-44xx.h
>> index 6d2776f..32a5eb5 100644
>> --- a/arch/arm/mach-omap2/prm-regbits-44xx.h
>> +++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
>> @@ -1063,6 +1063,14 @@
>> =A0#define OMAP4430_SCLL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
>> =A0#define OMAP4430_SCLL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xff << 8)
>>
>> +/* Used by PRM_VC_CFG_I2C_CLK */
>> +#define OMAP4430_HSCLH_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>> +#define OMAP4430_HSCLH_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xff << 16)
>> +
>> +/* Used by PRM_VC_CFG_I2C_CLK */
>> +#define OMAP4430_HSCLL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>> +#define OMAP4430_HSCLL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xff << 24)
>> +
>> =A0/* Used by PRM_RSTST */
>> =A0#define OMAP4430_SECURE_WDT_RST_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
>> =A0#define OMAP4430_SECURE_WDT_RST_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
>> index 8ca200d..79b9e86 100644
>> --- a/arch/arm/mach-omap2/vc.c
>> +++ b/arch/arm/mach-omap2/vc.c
>> @@ -191,14 +191,22 @@ static void __init omap3_vc_init_channel(struc=
t voltagedomain *voltdm)
>> =A0static void __init omap4_vc_init_channel(struct voltagedomain *vo=
ltdm)
>> =A0{
>> =A0 =A0 =A0 static bool is_initialized;
>> - =A0 =A0 u32 vc_val;
>> + =A0 =A0 struct omap_voltdm_pmic *pmic =3D voltdm->pmic;
>> + =A0 =A0 u32 vc_val =3D 0;
>>
>> =A0 =A0 =A0 if (is_initialized)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 /* XXX These are magic numbers and do not belong! */
>> - =A0 =A0 vc_val =3D (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430=
_SCLH_SHIFT);
>> - =A0 =A0 voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
>> + =A0 =A0 if (pmic->i2c_high_speed) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 vc_val |=3D pmic->i2c_hscll_low << OMAP443=
0_HSCLL_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 vc_val |=3D pmic->i2c_hscll_high << OMAP44=
30_HSCLH_SHIFT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 vc_val |=3D pmic->i2c_scll_low << OMAP4430_SCLL_SHIFT;
>> + =A0 =A0 vc_val |=3D pmic->i2c_scll_high << OMAP4430_SCLH_SHIFT;
>> +
>> + =A0 =A0 if (vc_val)
>> + =A0 =A0 =A0 =A0 =A0 =A0 voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C=
_CLK_OFFSET);
>>
>> =A0 =A0 =A0 is_initialized =3D true;
>> =A0}
>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/vol=
tage.h
>> index 2f7b268..3fe56e4 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -118,6 +118,10 @@ struct omap_volt_data {
>> =A0 * @i2c_mcode: master code value for I2C high-speed preamble tran=
smission
>> =A0 * @vsel_to_uv: =A0 =A0 =A0PMIC API to convert vsel value to actu=
al voltage in uV.
>> =A0 * @uv_to_vsel: =A0 =A0 =A0PMIC API to convert voltage in uV to v=
sel value.
>> + * @i2c_hscll_low: PMIC interface speed config for highspeed mode (=
T low)
>> + * @i2c_hscll_high: PMIC interface speed config for highspeed mode =
(T high)
>> + * @i2c_scll_low: PMIC interface speed config for fullspeed mode (T=
 low)
>> + * @i2c_scll_high: PMIC interface speed config for fullspeed mode (=
T high)
>> =A0 */
>> =A0struct omap_voltdm_pmic {
>> =A0 =A0 =A0 int slew_rate;
>> @@ -137,6 +141,10 @@ struct omap_voltdm_pmic {
>> =A0 =A0 =A0 u8 volt_reg_addr;
>> =A0 =A0 =A0 u8 cmd_reg_addr;
>> =A0 =A0 =A0 bool i2c_high_speed;
>> + =A0 =A0 u8 i2c_hscll_low;
>> + =A0 =A0 u8 i2c_hscll_high;
>> + =A0 =A0 u8 i2c_scll_low;
>> + =A0 =A0 u8 i2c_scll_high;
>> =A0 =A0 =A0 u8 i2c_mcode;
>> =A0 =A0 =A0 unsigned long (*vsel_to_uv) (const u8 vsel);
>> =A0 =A0 =A0 u8 (*uv_to_vsel) (unsigned long uV);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
