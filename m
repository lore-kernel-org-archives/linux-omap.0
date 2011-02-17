From: "Sawant, Anand" <sawant@ti.com>
Subject: Re: [PATCH] omap2plus: smartreflex: remove sr debug directory in omap_sr_remove()
Date: Thu, 17 Feb 2011 21:39:39 +0530
Message-ID: <AANLkTi=H9iW+hwygrmUva_B1XAaUizUTyEtnzUCnCeWM@mail.gmail.com>
References: <1296912744-4768-1-git-send-email-sawant@ti.com>
	<87wrl65dwp.fsf@ti.com>
	<AANLkTik3h6ovXAkcU0xMPGEi93L0TqN45s0hpHGwj6CG@mail.gmail.com>
	<87d3mtwacf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43669 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755307Ab1BQQJk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 11:09:40 -0500
Received: by mail-gw0-f53.google.com with SMTP id 10so1690561gwb.40
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 08:09:39 -0800 (PST)
In-Reply-To: <87d3mtwacf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin,

On Tue, Feb 15, 2011 at 9:36 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Sawant, Anand" <sawant@ti.com> writes:
>
>> Kevin,
>>
>> On Sat, Feb 12, 2011 at 5:20 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Hi Anand,
>>>
>>> Anand S Sawant <sawant@ti.com> writes:
>>>
>>>> omap_sr_probe() creates the smartreflex debug directory and its
>>>> underlying nvalue debug directory. These directories are removed i=
n
>>>> omap_sr_remove().
>>>>
>>>> Basic smartreflex functionality tested on OMAP3630 Zoom3 & OMAP443=
0 SDP
>>>>
>>>> Signed-off-by: Anand S Sawant <sawant@ti.com>
>>>
>>> Looks good.
>>>
>>> Please repost with the linux-arm-kernel list in CC:
>>> linux-arm-kernel@lists.infradead.org. =A0Thend, unless there are ot=
her
>>> comments/objections, I'll queue this for 2.6.39.
>>>
>>
>> Thanks, will repost.
>>
>>> Also, can summarize on which platforms this was tested.
>>
>> I tested SR functionality at the default OPP on 3630 Zoom3 &
>> OMAP4430 SDP.
>
> What I was wondering is how you tested the functionality of the chang=
es
> you made, namely the sr-remove path.
>

Since SR is not built as a module, I explicitly invoked omap_sr_remove(=
) at
the end of omap_sr_probe(). Through a message print, I confirmed that
debugfs_remove_recursive() was getting called successfully.

The rest of the changes get tested when the smartreflex and nvalue debu=
g
directories are created successfully and smartreflex functionality work=
s at
the default OPP.

Best Regards,

Anand

> Kevin
>
>>> Just curious:
>>> Were you able to build SR as a module to test this?
>>>
>>
>> No.
>>
>> Best Regards,
>>
>> Anand S Sawant
>>> Kevin
>>>
>>>> ---
>>>> =A0arch/arm/mach-omap2/smartreflex.c | =A0 24 ++++++++++++++------=
----
>>>> =A01 files changed, 14 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-oma=
p2/smartreflex.c
>>>> index d7deadf..57df5cf 100644
>>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>>> @@ -54,6 +54,7 @@ struct omap_sr {
>>>> =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node;
>>>> =A0 =A0 =A0 struct omap_sr_nvalue_table =A0 =A0 *nvalue_table;
>>>> =A0 =A0 =A0 struct voltagedomain =A0 =A0 =A0 =A0 =A0 =A0*voltdm;
>>>> + =A0 =A0 struct dentry =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dbg_d=
ir;
>>>> =A0};
>>>>
>>>> =A0/* sr_list contains all the instances of smartreflex module */
>>>> @@ -822,7 +823,7 @@ static int __init omap_sr_probe(struct platfor=
m_device *pdev)
>>>> =A0 =A0 =A0 struct omap_sr *sr_info =3D kzalloc(sizeof(struct omap=
_sr), GFP_KERNEL);
>>>> =A0 =A0 =A0 struct omap_sr_data *pdata =3D pdev->dev.platform_data=
;
>>>> =A0 =A0 =A0 struct resource *mem, *irq;
>>>> - =A0 =A0 struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
>>>> + =A0 =A0 struct dentry *vdd_dbg_dir, *nvalue_dir;
>>>> =A0 =A0 =A0 struct omap_volt_data *volt_data;
>>>> =A0 =A0 =A0 int i, ret =3D 0;
>>>>
>>>> @@ -894,23 +895,24 @@ static int __init omap_sr_probe(struct platf=
orm_device *pdev)
>>>> =A0 =A0 =A0 if (!vdd_dbg_dir)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>>>
>>>> - =A0 =A0 dbg_dir =3D debugfs_create_dir("smartreflex", vdd_dbg_di=
r);
>>>> - =A0 =A0 if (IS_ERR(dbg_dir)) {
>>>> + =A0 =A0 sr_info->dbg_dir =3D debugfs_create_dir("smartreflex", v=
dd_dbg_dir);
>>>> + =A0 =A0 if (IS_ERR(sr_info->dbg_dir)) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "%s: Unable to cre=
ate debugfs directory\n",
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(dbg_dir);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(sr_info->dbg_dir);
>>>> =A0 =A0 =A0 }
>>>>
>>>> - =A0 =A0 (void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO=
, dbg_dir,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)=
sr_info, &pm_sr_fops);
>>>> - =A0 =A0 (void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
>>>> + =A0 =A0 /* Using S_IWUSR to fix checkpatch warning */
>>>> + =A0 =A0 (void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR=
,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_info->dbg_dir, (void =
*)sr_info, &pm_sr_fops);
>>>> + =A0 =A0 (void) debugfs_create_x32("errweight", S_IRUGO, sr_info-=
>dbg_dir,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sr_info->err_weight);
>>>> - =A0 =A0 (void) debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_di=
r,
>>>> + =A0 =A0 (void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_inf=
o->dbg_dir,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sr_info->err_maxlimit=
);
>>>> - =A0 =A0 (void) debugfs_create_x32("errminlimit", S_IRUGO, dbg_di=
r,
>>>> + =A0 =A0 (void) debugfs_create_x32("errminlimit", S_IRUGO, sr_inf=
o->dbg_dir,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sr_info->err_minlimit=
);
>>>>
>>>> - =A0 =A0 nvalue_dir =3D debugfs_create_dir("nvalue", dbg_dir);
>>>> + =A0 =A0 nvalue_dir =3D debugfs_create_dir("nvalue", sr_info->dbg=
_dir);
>>>> =A0 =A0 =A0 if (IS_ERR(nvalue_dir)) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "%s: Unable to cre=
ate debugfs directory"
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for n-values\n", __fu=
nc__);
>>>> @@ -974,6 +976,8 @@ static int __devexit omap_sr_remove(struct pla=
tform_device *pdev)
>>>>
>>>> =A0 =A0 =A0 if (sr_info->autocomp_active)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_stop_vddautocomp(sr_info);
>>>> + =A0 =A0 if (sr_info->dbg_dir)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 debugfs_remove_recursive(sr_info->dbg_di=
r);
>>>>
>>>> =A0 =A0 =A0 list_del(&sr_info->node);
>>>> =A0 =A0 =A0 iounmap(sr_info->base);
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
