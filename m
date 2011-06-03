From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] omap: cleanup NAND platform data
Date: Sat, 4 Jun 2011 01:05:16 +0300
Message-ID: <BANLkTimXxOcr4q2fkD0hjq4pMVPC0StBFw@mail.gmail.com>
References: <1307130993-15265-1-git-send-email-notasas@gmail.com>
	<BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49607 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab1FCWFR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 18:05:17 -0400
Received: by vxi39 with SMTP id 39so1694216vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 15:05:17 -0700 (PDT)
In-Reply-To: <BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Sat, Jun 4, 2011 at 12:14 AM, Vimal Singh <vimal.newwork@gmail.com> =
wrote:
> On Sat, Jun 4, 2011 at 1:26 AM, Grazvydas Ignotas <notasas@gmail.com>=
 wrote:
>>
>> -static int omap2_nand_gpmc_retime(void)
>> +static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *g=
pmc_nand_data)
>> =A0{
>> =A0 =A0 =A0 =A0struct gpmc_timings t;
>> =A0 =A0 =A0 =A0int err;
>> @@ -83,13 +81,11 @@ static int omap2_nand_gpmc_retime(void)
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_dat=
a)
>> +int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand=
_data)
>> =A0{
>> =A0 =A0 =A0 =A0int err =3D 0;
>> =A0 =A0 =A0 =A0struct device *dev =3D &gpmc_nand_device.dev;
>>
>> - =A0 =A0 =A0 gpmc_nand_data =3D _nand_data;
>> - =A0 =A0 =A0 gpmc_nand_data->nand_setup =3D omap2_nand_gpmc_retime;
>
> Purpose of doing this was to be able to utilise
> 'omap2_nand_gpmc_retime', when DVFS is ready to use it,
> for changing timing parameter dynamically when a frequency change is =
done.

Well but it seems currently ...retime() only does single static
configuration, I guess when it's updated to do DVFS stuff callback can
easily be added back..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
