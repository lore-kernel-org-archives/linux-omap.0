From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Thu, 12 May 2011 10:34:36 +0530
Message-ID: <BANLkTi=m_0whpiWzq0tzuNsYhd40mqizFw@mail.gmail.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
	<BANLkTin07ZkWwhMtqUEMhLtwugKNmhku9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33817 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061Ab1ELFEi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 01:04:38 -0400
Received: by mail-bw0-f41.google.com with SMTP id 17so1066564bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 22:04:36 -0700 (PDT)
In-Reply-To: <BANLkTin07ZkWwhMtqUEMhLtwugKNmhku9g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, May 11, 2011 at 10:06 PM, Todd Poynor <toddpoynor@google.com> w=
rote:
> On Wed, May 11, 2011 at 2:12 AM, Shweta Gulati <shweta.gulati@ti.com>=
 wrote:
> ...
>>
>> diff --git a/arch/arm/mach-omap2/sr_device.c
>> b/arch/arm/mach-omap2/sr_device.c
>> index 2782d3f..65b2aae 100644
>> --- a/arch/arm/mach-omap2/sr_device.c
>> +++ b/arch/arm/mach-omap2/sr_device.c
>> @@ -82,6 +82,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void
>> *user)
>> =A0 =A0 =A0 =A0struct omap_sr_data *sr_data;
>> =A0 =A0 =A0 =A0struct omap_device *od;
>> =A0 =A0 =A0 =A0struct omap_volt_data *volt_data;
>> + =A0 =A0 =A0 struct omap_sr_dev_attr *sr_dev_attr;
>> =A0 =A0 =A0 =A0char *name =3D "smartreflex";
>> =A0 =A0 =A0 =A0static int i;
>>
>> @@ -92,9 +93,11 @@ static int sr_dev_init(struct omap_hwmod *oh, voi=
d
>> *user)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (!oh->vdd_name) {
>> + =A0 =A0 =A0 sr_dev_attr =3D (struct omap_sr_dev_attr *)oh->dev_att=
r;
>> + =A0 =A0 =A0 if (!sr_dev_attr->voltdm_name) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No voltage domain specifi=
ed for %s."
>
> Suggest if (!sr_dev_attr ||=A0!sr_dev_attr->voltdm_name) to catch thi=
s error.
=46air enough, Thanks for catching
NULL pointer shouldn't be deferenced.
>
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Cannot initialize\n",=
 __func__, oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Canno=
t initialize\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sr_dev_attr->voltdm_name);
>
> Should leave the hwmod's oh->name as the pr_err
> param,=A0sr_dev_attr->voltdm_name has just been verified bogus.
=46air, will do.
> Todd
>
>

Thanks for reviewing.

--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
