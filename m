From: "Sawant, Anand" <sawant@ti.com>
Subject: Re: [PATCH] omap2plus: smartreflex: remove sr debug directory in omap_sr_remove()
Date: Tue, 15 Feb 2011 10:56:17 +0530
Message-ID: <AANLkTik3h6ovXAkcU0xMPGEi93L0TqN45s0hpHGwj6CG@mail.gmail.com>
References: <1296912744-4768-1-git-send-email-sawant@ti.com>
	<87wrl65dwp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:47188 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751076Ab1BOF0S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 00:26:18 -0500
Received: by mail-yx0-f170.google.com with SMTP id 33so2563002yxt.29
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 21:26:17 -0800 (PST)
In-Reply-To: <87wrl65dwp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin,

On Sat, Feb 12, 2011 at 5:20 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Anand,
>
> Anand S Sawant <sawant@ti.com> writes:
>
>> omap_sr_probe() creates the smartreflex debug directory and its
>> underlying nvalue debug directory. These directories are removed in
>> omap_sr_remove().
>>
>> Basic smartreflex functionality tested on OMAP3630 Zoom3 & OMAP4430 =
SDP
>>
>> Signed-off-by: Anand S Sawant <sawant@ti.com>
>
> Looks good.
>
> Please repost with the linux-arm-kernel list in CC:
> linux-arm-kernel@lists.infradead.org. =A0Thend, unless there are othe=
r
> comments/objections, I'll queue this for 2.6.39.
>

Thanks, will repost.

> Also, can summarize on which platforms this was tested.

I tested SR functionality at the default OPP on 3630 Zoom3 &
OMAP4430 SDP.

> Just curious:
> Were you able to build SR as a module to test this?
>

No.

Best Regards,

Anand S Sawant
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/smartreflex.c | =A0 24 ++++++++++++++--------=
--
>> =A01 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2=
/smartreflex.c
>> index d7deadf..57df5cf 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -54,6 +54,7 @@ struct omap_sr {
>> =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node;
>> =A0 =A0 =A0 struct omap_sr_nvalue_table =A0 =A0 *nvalue_table;
>> =A0 =A0 =A0 struct voltagedomain =A0 =A0 =A0 =A0 =A0 =A0*voltdm;
>> + =A0 =A0 struct dentry =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dbg_dir=
;
>> =A0};
>>
>> =A0/* sr_list contains all the instances of smartreflex module */
>> @@ -822,7 +823,7 @@ static int __init omap_sr_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 struct omap_sr *sr_info =3D kzalloc(sizeof(struct omap_s=
r), GFP_KERNEL);
>> =A0 =A0 =A0 struct omap_sr_data *pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 struct resource *mem, *irq;
>> - =A0 =A0 struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
>> + =A0 =A0 struct dentry *vdd_dbg_dir, *nvalue_dir;
>> =A0 =A0 =A0 struct omap_volt_data *volt_data;
>> =A0 =A0 =A0 int i, ret =3D 0;
>>
>> @@ -894,23 +895,24 @@ static int __init omap_sr_probe(struct platfor=
m_device *pdev)
>> =A0 =A0 =A0 if (!vdd_dbg_dir)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 dbg_dir =3D debugfs_create_dir("smartreflex", vdd_dbg_dir)=
;
>> - =A0 =A0 if (IS_ERR(dbg_dir)) {
>> + =A0 =A0 sr_info->dbg_dir =3D debugfs_create_dir("smartreflex", vdd=
_dbg_dir);
>> + =A0 =A0 if (IS_ERR(sr_info->dbg_dir)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "%s: Unable to creat=
e debugfs directory\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(dbg_dir);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(sr_info->dbg_dir);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 (void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, =
dbg_dir,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)sr=
_info, &pm_sr_fops);
>> - =A0 =A0 (void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
>> + =A0 =A0 /* Using S_IWUSR to fix checkpatch warning */
>> + =A0 =A0 (void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_info->dbg_dir, (void *)=
sr_info, &pm_sr_fops);
>> + =A0 =A0 (void) debugfs_create_x32("errweight", S_IRUGO, sr_info->d=
bg_dir,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sr_info->err_weight);
>> - =A0 =A0 (void) debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_dir,
>> + =A0 =A0 (void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info-=
>dbg_dir,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sr_info->err_maxlimit);
>> - =A0 =A0 (void) debugfs_create_x32("errminlimit", S_IRUGO, dbg_dir,
>> + =A0 =A0 (void) debugfs_create_x32("errminlimit", S_IRUGO, sr_info-=
>dbg_dir,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sr_info->err_minlimit);
>>
>> - =A0 =A0 nvalue_dir =3D debugfs_create_dir("nvalue", dbg_dir);
>> + =A0 =A0 nvalue_dir =3D debugfs_create_dir("nvalue", sr_info->dbg_d=
ir);
>> =A0 =A0 =A0 if (IS_ERR(nvalue_dir)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "%s: Unable to creat=
e debugfs directory"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for n-values\n", __func=
__);
>> @@ -974,6 +976,8 @@ static int __devexit omap_sr_remove(struct platf=
orm_device *pdev)
>>
>> =A0 =A0 =A0 if (sr_info->autocomp_active)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_stop_vddautocomp(sr_info);
>> + =A0 =A0 if (sr_info->dbg_dir)
>> + =A0 =A0 =A0 =A0 =A0 =A0 debugfs_remove_recursive(sr_info->dbg_dir)=
;
>>
>> =A0 =A0 =A0 list_del(&sr_info->node);
>> =A0 =A0 =A0 iounmap(sr_info->base);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
