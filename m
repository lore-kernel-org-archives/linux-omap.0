From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 10/10] [PM-WIP-MMC] omap4 hsmmc: Fix the init if
 CONFIG_MMC_OMAP_HS is not set
Date: Fri, 27 Aug 2010 19:50:26 +0530
Message-ID: <AANLkTinzTtMQb57ph9AvufqCGP+qZjxdAo7h_yfPO6aG@mail.gmail.com>
References: <16186.10.24.255.18.1282335083.squirrel@dbdmail.itg.ti.com>
	<87mxs9ufdf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52012 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0H0OU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:20:27 -0400
Received: by vws3 with SMTP id 3so2902855vws.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 07:20:27 -0700 (PDT)
In-Reply-To: <87mxs9ufdf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, madhu.cr@ti.com

On Fri, Aug 27, 2010 at 4:54 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "kishore kadiyala" <kishore.kadiyala@ti.com> writes:
>
>> From: Benoit Cousson <b-cousson@ti.com
>> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Adrian Hunter <adrian.hunter@nokia.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
> This is another fix that should go upstream independently of the rest=
 of
> the series.
>
> In fact, this should probably be fixed in 2.6.36-rc.

ok will post independently

Regards,
Kishore
>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index 9447644..3a0dafd 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -235,8 +235,13 @@ static int omap4_twl6030_hsmmc_late_init(struct=
 device *dev)
>>
>> =A0static __init void omap4_twl6030_hsmmc_set_late_init(struct devic=
e *dev)
>> =A0{
>> - =A0 =A0 struct omap_mmc_platform_data *pdata =3D dev->platform_dat=
a;
>> + =A0 =A0 struct omap_mmc_platform_data *pdata;
>> +
>> + =A0 =A0 /* dev can be null if CONFIG_MMC_OMAP_HS is not set */
>> + =A0 =A0 if (!dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 pdata =3D dev->platform_data;
>> =A0 =A0 =A0 pdata->init =3D =A0 omap4_twl6030_hsmmc_late_init;
>> =A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
