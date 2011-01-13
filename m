From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issues with ADATA SD cards on OMAP?
Date: Thu, 13 Jan 2011 05:34:28 -0800
Message-ID: <AANLkTik2rq1=Uhs+Nxn4oMCsUzpKG-_PF3qWYZYo6jWF@mail.gmail.com>
References: <AANLkTinw=ZjiOr1KHNxu1Npq5iLucOPyw0Gumdyq1jjS@mail.gmail.com>
	<AANLkTi=SKb9wCUMyvvT59qYCMm8wViZRAYgtDOJXiLKy@mail.gmail.com>
	<B00BD5DB-31BB-42C8-B360-241173342F86@mac.com>
	<AANLkTik8wTknohEDfNnoYsZt8xuQRb48gUC7T_Xg+afz@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036A6F2808@dbde02.ent.ti.com>
	<AANLkTimo_7zK0WT81jJ1F2iat+9G0aC0O=4pJPt6O4J2@mail.gmail.com>
	<AANLkTimzYff_9PSSMpiXAyVX0FGHafVdBusCCGNyZqQP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58984 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab1AMNe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 08:34:29 -0500
Received: by qwa26 with SMTP id 26so1791648qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 05:34:28 -0800 (PST)
In-Reply-To: <AANLkTimzYff_9PSSMpiXAyVX0FGHafVdBusCCGNyZqQP@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Elvis Dowson <elvis.dowson@mac.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Wed, Jan 12, 2011 at 8:30 PM, Steve Sakoman <sakoman@gmail.com> wrot=
e:
> On Wed, Jan 12, 2011 at 9:48 AM, Steve Sakoman <sakoman@gmail.com> wr=
ote:
>> On Tue, Jan 11, 2011 at 10:17 PM, Ghorai, Sukumar <s-ghorai@ti.com> =
wrote:
>>
>>> [Ghorai]
>>> We also experienced the same issue using 32GB SD card for omap3 and=
 omap4.
>>> And the problem is seen is that DTO value (in SYSCTL) is not curren=
t
>>> in following function.
>>>
>>> So add the following modification and please update the status.
>>> And we will submit proper patch towards the same.
>>>
>>> static void set_data_timeout(..){
>>> ...
>>> =A0 =A0 =A0cycle_ns =3D 1000000000 / (clk_get_rate(host->fclk) / cl=
kd);
>>> =A0 =A0 =A0 =A0timeout =3D timeout_ns / cycle_ns;
>>> =A0 =A0 =A0 =A0timeout +=3D timeout_clks;
>>> + timeout *=3D2;
>>> =A0 =A0 =A0if (timeout) {
>>> ...
>>> }
>>
>> I tried this change. =A0While it seemed to improve things a bit for =
the
>> ADATA card I tested, I was still not able to boot successfully.
>>
>> I will investigate further. =A0Forcing a value of 14 makes the card
>> work. =A0I'll add a printk to see what dto value is computed by your
>> patch.
>
> The printk showed that dto was being set in the range 11-13 with your=
 patch.
>
> I still was seeing some corruption occurring with the patch -- but at
> a much lower level that without the patch.
>
> Since I knew that the card would definitely work if dto were hard
> coded to 14, I next tried bumping the value your patch computed by 1:
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 9c7c590..09a7e21 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1372,6 +1372,7 @@ static void set_data_timeout(struct omap_hsmmc_=
host *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dto -=3D 13;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dto =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dto++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dto > 14)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dto =3D 14;
> =A0 =A0 =A0 =A0}
>
> I've been running fairly intensive testing for the past 6 hours with =
out issue.

Just to add another data point, Transcend 16GB Class 6 cards will not
work on OMAP3 with an unpatched kernel -- lots of -110 timeout errors.

With the patches above the card does work.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
