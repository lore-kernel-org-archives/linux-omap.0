From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap2plus: smartreflex: remove sr debug directory in omap_sr_remove()
Date: Tue, 15 Feb 2011 08:06:56 -0800
Message-ID: <87d3mtwacf.fsf@ti.com>
References: <1296912744-4768-1-git-send-email-sawant@ti.com>
	<87wrl65dwp.fsf@ti.com>
	<AANLkTik3h6ovXAkcU0xMPGEi93L0TqN45s0hpHGwj6CG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59358 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754999Ab1BOQHF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 11:07:05 -0500
Received: by yie30 with SMTP id 30so146767yie.11
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 08:07:00 -0800 (PST)
In-Reply-To: <AANLkTik3h6ovXAkcU0xMPGEi93L0TqN45s0hpHGwj6CG@mail.gmail.com>
	(Anand Sawant's message of "Tue, 15 Feb 2011 10:56:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sawant, Anand" <sawant@ti.com>
Cc: linux-omap@vger.kernel.org

"Sawant, Anand" <sawant@ti.com> writes:

> Kevin,
>
> On Sat, Feb 12, 2011 at 5:20 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Hi Anand,
>>
>> Anand S Sawant <sawant@ti.com> writes:
>>
>>> omap_sr_probe() creates the smartreflex debug directory and its
>>> underlying nvalue debug directory. These directories are removed in
>>> omap_sr_remove().
>>>
>>> Basic smartreflex functionality tested on OMAP3630 Zoom3 & OMAP4430=
 SDP
>>>
>>> Signed-off-by: Anand S Sawant <sawant@ti.com>
>>
>> Looks good.
>>
>> Please repost with the linux-arm-kernel list in CC:
>> linux-arm-kernel@lists.infradead.org. =C2=A0Thend, unless there are =
other
>> comments/objections, I'll queue this for 2.6.39.
>>
>
> Thanks, will repost.
>
>> Also, can summarize on which platforms this was tested.
>
> I tested SR functionality at the default OPP on 3630 Zoom3 &
> OMAP4430 SDP.

What I was wondering is how you tested the functionality of the changes
you made, namely the sr-remove path.

Kevin

>> Just curious:
>> Were you able to build SR as a module to test this?
>>
>
> No.
>
> Best Regards,
>
> Anand S Sawant
>> Kevin
>>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/smartreflex.c | =C2=A0 24 ++++++++++++++-=
---------
>>> =C2=A01 files changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap=
2/smartreflex.c
>>> index d7deadf..57df5cf 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -54,6 +54,7 @@ struct omap_sr {
>>> =C2=A0 =C2=A0 =C2=A0 struct list_head =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0node;
>>> =C2=A0 =C2=A0 =C2=A0 struct omap_sr_nvalue_table =C2=A0 =C2=A0 *nva=
lue_table;
>>> =C2=A0 =C2=A0 =C2=A0 struct voltagedomain =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*voltdm;
>>> + =C2=A0 =C2=A0 struct dentry =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *dbg_dir;
>>> =C2=A0};
>>>
>>> =C2=A0/* sr_list contains all the instances of smartreflex module *=
/
>>> @@ -822,7 +823,7 @@ static int __init omap_sr_probe(struct platform=
_device *pdev)
>>> =C2=A0 =C2=A0 =C2=A0 struct omap_sr *sr_info =3D kzalloc(sizeof(str=
uct omap_sr), GFP_KERNEL);
>>> =C2=A0 =C2=A0 =C2=A0 struct omap_sr_data *pdata =3D pdev->dev.platf=
orm_data;
>>> =C2=A0 =C2=A0 =C2=A0 struct resource *mem, *irq;
>>> - =C2=A0 =C2=A0 struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
>>> + =C2=A0 =C2=A0 struct dentry *vdd_dbg_dir, *nvalue_dir;
>>> =C2=A0 =C2=A0 =C2=A0 struct omap_volt_data *volt_data;
>>> =C2=A0 =C2=A0 =C2=A0 int i, ret =3D 0;
>>>
>>> @@ -894,23 +895,24 @@ static int __init omap_sr_probe(struct platfo=
rm_device *pdev)
>>> =C2=A0 =C2=A0 =C2=A0 if (!vdd_dbg_dir)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>>
>>> - =C2=A0 =C2=A0 dbg_dir =3D debugfs_create_dir("smartreflex", vdd_d=
bg_dir);
>>> - =C2=A0 =C2=A0 if (IS_ERR(dbg_dir)) {
>>> + =C2=A0 =C2=A0 sr_info->dbg_dir =3D debugfs_create_dir("smartrefle=
x", vdd_dbg_dir);
>>> + =C2=A0 =C2=A0 if (IS_ERR(sr_info->dbg_dir)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "%s: Unable to create debugfs directory\n",
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(dbg_dir)=
;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(sr_info-=
>dbg_dir);
>>> =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> - =C2=A0 =C2=A0 (void) debugfs_create_file("autocomp", S_IRUGO | S_=
IWUGO, dbg_dir,
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)sr_info, &pm_sr_fops);
>>> - =C2=A0 =C2=A0 (void) debugfs_create_x32("errweight", S_IRUGO, dbg=
_dir,
>>> + =C2=A0 =C2=A0 /* Using S_IWUSR to fix checkpatch warning */
>>> + =C2=A0 =C2=A0 (void) debugfs_create_file("autocomp", S_IRUGO | S_=
IWUSR,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sr_info->dbg_dir, (void *)sr_info, &pm_sr_fops);
>>> + =C2=A0 =C2=A0 (void) debugfs_create_x32("errweight", S_IRUGO, sr_=
info->dbg_dir,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &sr_info->err_weight);
>>> - =C2=A0 =C2=A0 (void) debugfs_create_x32("errmaxlimit", S_IRUGO, d=
bg_dir,
>>> + =C2=A0 =C2=A0 (void) debugfs_create_x32("errmaxlimit", S_IRUGO, s=
r_info->dbg_dir,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &sr_info->err_maxlimit);
>>> - =C2=A0 =C2=A0 (void) debugfs_create_x32("errminlimit", S_IRUGO, d=
bg_dir,
>>> + =C2=A0 =C2=A0 (void) debugfs_create_x32("errminlimit", S_IRUGO, s=
r_info->dbg_dir,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &sr_info->err_minlimit);
>>>
>>> - =C2=A0 =C2=A0 nvalue_dir =3D debugfs_create_dir("nvalue", dbg_dir=
);
>>> + =C2=A0 =C2=A0 nvalue_dir =3D debugfs_create_dir("nvalue", sr_info=
->dbg_dir);
>>> =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(nvalue_dir)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "%s: Unable to create debugfs directory"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "for n-values\n", __func__);
>>> @@ -974,6 +976,8 @@ static int __devexit omap_sr_remove(struct plat=
form_device *pdev)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 if (sr_info->autocomp_active)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sr_stop_vddautocom=
p(sr_info);
>>> + =C2=A0 =C2=A0 if (sr_info->dbg_dir)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 debugfs_remove_recursiv=
e(sr_info->dbg_dir);
>>>
>>> =C2=A0 =C2=A0 =C2=A0 list_del(&sr_info->node);
>>> =C2=A0 =C2=A0 =C2=A0 iounmap(sr_info->base);
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
