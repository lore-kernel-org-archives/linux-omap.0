From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 07/10] ARM: OMAP2+: SmartReflex: Use per-OPP data
 structure
Date: Fri, 11 May 2012 09:21:24 +0530
Message-ID: <CAJ6a13akLHpBi5HrA__j8oV09R_eLrsrw2gju-H3j7fQ46o0qw@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <1335462041-4949-8-git-send-email-j-keerthy@ti.com>
 <44C9A5C2B412554B8C50A260EB4EF32703971E34@DFLE32.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <44C9A5C2B412554B8C50A260EB4EF32703971E34@DFLE32.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Guyotte, Greg" <gguyotte@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "Gopinath, Thara" <thara@ti.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pihet-XID,
 Jean" <j-pihet@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Greg,

Thanks for reviewing.

On Fri, May 11, 2012 at 12:41 AM, Guyotte, Greg <gguyotte@ti.com> wrote:
> Hi Jean,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of J, KEERTHY
>> Sent: Thursday, April 26, 2012 12:41 PM
>> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> Hilman, Kevin; rjw@sisk.pl; linux-kernel@vger.kernel.org; linux-
>> pm@lists.linux-foundation.org
>> Cc: Pihet-XID, Jean; J, KEERTHY; Paul Walmsley; Gopinath, Thara; Menon,
>> Nishanth
>> Subject: [PATCH V3 07/10] ARM: OMAP2+: SmartReflex: Use per-OPP data
>> structure
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The SmartReflex driver incorrectly treats some per-OPP data as data
>> common to all OPPs (e.g., ERRMINLIMIT). =A0Move this data into a per-OPP
>> data structure.
>>
>> Furthermore, in order to make the SmartReflex implementation ready for
>> the move to drivers/, remove the dependency from the SR driver code
>> to the voltage layer by querying the data tables only from the SR device
>> init code.
>>
>> Based on Paul's original code for the SmartReflex driver conversion.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Signed-off-by: J Keerthy <j-keerthy@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Thara Gopinath <thara@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/smartreflex.c | =A0 38 +++++++++++++++++---------=
------
>> ----
>> =A0arch/arm/mach-omap2/sr_device.c =A0 | =A0 36 ++++++++++++++++++++++++=
+++++---
>> --
>> =A0include/linux/power/smartreflex.h | =A0 =A08 +++++-
>> =A03 files changed, 54 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-
>> omap2/smartreflex.c
>> index acef08d..20075de 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -347,22 +347,23 @@ static void sr_v2_disable(struct omap_sr *sr)
>> =A0 =A0 =A0 sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
>> =A0}
>>
>> -static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
>> +static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_sr=
 *sr, u32 efuse_offs)
>> =A0{
>> =A0 =A0 =A0 int i;
>>
>> =A0 =A0 =A0 if (!sr->nvalue_table) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: Missing ntarge=
t value table\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 for (i =3D 0; i < sr->nvalue_count; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sr->nvalue_table[i].efuse_offs =3D=3D ef=
use_offs)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sr->nvalue_table[i].nva=
lue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &sr->nvalue_table[i];
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 return 0;
>> + =A0 =A0 return NULL;
>> =A0}
>>
>> =A0/* Public Functions */
>> @@ -586,7 +587,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned
>> long volt)
>> =A0{
>> =A0 =A0 =A0 struct omap_volt_data *volt_data;
>> =A0 =A0 =A0 struct omap_sr *sr =3D _sr_lookup(voltdm);
>> - =A0 =A0 u32 nvalue_reciprocal;
>> + =A0 =A0 struct omap_sr_nvalue_table *nvalue_row;
>> =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 if (IS_ERR(sr)) {
>> @@ -602,16 +603,16 @@ int sr_enable(struct voltagedomain *voltdm, unsign=
ed
>> long volt)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(volt_data);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 nvalue_reciprocal =3D sr_retrieve_nvalue(sr, volt_data-
>> >sr_efuse_offs);
>> + =A0 =A0 nvalue_row =3D sr_retrieve_nvalue_row(sr, volt_data->sr_efuse_=
offs);
>>
>> - =A0 =A0 if (!nvalue_reciprocal) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: NVALUE =3D 0 at =
voltage %ld\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, volt);
>> + =A0 =A0 if (!nvalue_row) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: failure getting =
SR data for this
>> voltage %ld\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, volt);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* errminlimit is opp dependent and hence linked to voltage =
*/
>> - =A0 =A0 sr->err_minlimit =3D volt_data->sr_errminlimit;
>> + =A0 =A0 sr->err_minlimit =3D nvalue_row->errminlimit;
>>
>> =A0 =A0 =A0 pm_runtime_get_sync(&sr->pdev->dev);
>>
>> @@ -624,7 +625,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned
>> long volt)
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>
>> - =A0 =A0 sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
>> + =A0 =A0 sr_write_reg(sr, NVALUERECIPROCAL, nvalue_row->nvalue);
>>
>> =A0 =A0 =A0 /* SRCONFIG - enable SR */
>> =A0 =A0 =A0 sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SREN=
ABLE);
>> @@ -872,7 +873,6 @@ static int __init omap_sr_probe(struct platform_devi=
ce
>> *pdev)
>> =A0 =A0 =A0 struct omap_sr_data *pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 struct resource *mem, *irq;
>> =A0 =A0 =A0 struct dentry *nvalue_dir;
>> - =A0 =A0 struct omap_volt_data *volt_data;
>> =A0 =A0 =A0 int i, ret =3D 0;
>>
>> =A0 =A0 =A0 sr_info =3D kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
>> @@ -990,12 +990,10 @@ static int __init omap_sr_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_debugfs;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
>> - =A0 =A0 if (!volt_data) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "%s: %s: No Voltage table=
 for the"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " corresponding vdd. Cannot cr=
eate debugfs"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "entries for n-values\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, sr_info->name);
>> + =A0 =A0 if (sr_info->nvalue_count =3D=3D 0 || !sr_info->nvalue_table) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "%s: %s: No Voltage table=
 for the
>> corresponding vdd. Cannot create debugfs entries for n-values\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, sr_info->name);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODATA;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_debugfs;
>> =A0 =A0 =A0 }
>> @@ -1003,8 +1001,8 @@ static int __init omap_sr_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 for (i =3D 0; i < sr_info->nvalue_count; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 char name[NVALUE_NAME_LEN + 1];
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 snprintf(name, sizeof(name), "volt_%d",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0volt_data[i].volt_nominal);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(name, sizeof(name), "volt_%lu",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_info->nvalu=
e_table[i].volt_nominal);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) debugfs_create_x32(name, S_IRUGO | S_=
IWUSR, nvalue_dir,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(sr_info->n=
value_table[i].nvalue));
>> =A0 =A0 =A0 }
>> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-
>> omap2/sr_device.c
>> index e081174..e107e39 100644
>> --- a/arch/arm/mach-omap2/sr_device.c
>> +++ b/arch/arm/mach-omap2/sr_device.c
>> @@ -36,7 +36,10 @@ static void __init sr_set_nvalues(struct omap_volt_da=
ta
>> *volt_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
sr_data *sr_data)
>> =A0{
>> =A0 =A0 =A0 struct omap_sr_nvalue_table *nvalue_table;
>> - =A0 =A0 int i, count =3D 0;
>> + =A0 =A0 int i, j, count =3D 0;
>> +
>> + =A0 =A0 sr_data->nvalue_count =3D 0;
>> + =A0 =A0 sr_data->nvalue_table =3D NULL;
>>
>> =A0 =A0 =A0 while (volt_data[count].volt_nominal)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> @@ -44,8 +47,14 @@ static void __init sr_set_nvalues(struct omap_volt_da=
ta
>> *volt_data,
>> =A0 =A0 =A0 nvalue_table =3D kzalloc(sizeof(struct omap_sr_nvalue_table)=
*count,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
>>
>> - =A0 =A0 for (i =3D 0; i < count; i++) {
>> + =A0 =A0 if (!nvalue_table) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OMAP: SmartReflex: cannot allocate mem=
ory for n-value
>> table\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (i =3D 0, j =3D 0; i < count; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 v;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In OMAP4 the efuse registers are 24 bit=
 aligned.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* A __raw_readl will fail for non-32 bit =
aligned address
>> @@ -58,15 +67,30 @@ static void __init sr_set_nvalues(struct
>> omap_volt_data *volt_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_re=
adb(offset + 1) << 8 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_re=
adb(offset + 2) << 16;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0v =3D omap_ctrl_readl(volt_=
data[i].sr_efuse_offs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D omap_ctrl_readl(volt_dat=
a[i].sr_efuse_offs);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 nvalue_table[i].efuse_offs =3D volt_data[i].sr=
_efuse_offs;
>> - =A0 =A0 =A0 =A0 =A0 =A0 nvalue_table[i].nvalue =3D v;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Many OMAP SoCs don't have the eFuse value=
s set.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For example, pretty much all OMAP3xxx bef=
ore
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* ES3.something.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* XXX There needs to be some way for board =
files or
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* userspace to add these in.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (v =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 nvalue_table[j].nvalue =3D v;
>> + =A0 =A0 =A0 =A0 =A0 =A0 nvalue_table[j].efuse_offs =3D volt_data[i].sr=
_efuse_offs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 nvalue_table[j].errminlimit =3D volt_data[i].s=
r_errminlimit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 nvalue_table[j].volt_nominal =3D volt_data[i].=
volt_nominal;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 j++;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 sr_data->nvalue_table =3D nvalue_table;
>> - =A0 =A0 sr_data->nvalue_count =3D count;
>> + =A0 =A0 sr_data->nvalue_count =3D j;
>> =A0}
>>
>> =A0static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
>> diff --git a/include/linux/power/smartreflex.h
>> b/include/linux/power/smartreflex.h
>> index 78b795e..222f901 100644
>> --- a/include/linux/power/smartreflex.h
>> +++ b/include/linux/power/smartreflex.h
>> @@ -243,12 +243,16 @@ struct omap_sr_class_data {
>> =A0/**
>> =A0 * struct omap_sr_nvalue_table =A0 =A0 =A0 - Smartreflex n-target val=
ue info
>> =A0 *
>> - * @efuse_offs: =A0 =A0 =A0The offset of the efuse where n-target value=
s are stored.
>> - * @nvalue: =A0The n-target value.
>> + * @efuse_offs: =A0 =A0 =A0 =A0The offset of the efuse where n-target v=
alues are
>> stored.
>> + * @nvalue: =A0 =A0The n-target value.
>> + * @errminlimit: =A0The value of the ERRMINLIMIT bitfield for this n-ta=
rget
>> + * @volt_nominal: microvolts DC that the VDD is initially programmed to
>> =A0 */
>> =A0struct omap_sr_nvalue_table {
>> =A0 =A0 =A0 u32 efuse_offs;
>> =A0 =A0 =A0 u32 nvalue;
>> + =A0 =A0 u32 errminlimit;
>> + =A0 =A0 unsigned long volt_nominal;
>
> [GG] I would suggest that we also need to add errmaxlimit and errweight f=
ields to this structure. =A0These are very much possible to change per OPP,=
 though it hasn't been common in implementations up to now.

Ok. Since this patch set is focussed on minimal clean up and moving the code
from mach-omap to drivers this is not addressed. I will sure take this up o=
nce
this is moved.

>
>> =A0};
>>
>> =A0/**
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



-- =

Regards and Thanks,
Keerthy
