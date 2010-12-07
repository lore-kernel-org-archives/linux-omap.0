From: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Tue, 7 Dec 2010 14:58:28 -0600
Message-ID: <AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
	<4CFE9059.1080202@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42006 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754643Ab0LGU6e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 15:58:34 -0500
Received: by mail-gx0-f181.google.com with SMTP id 10so362215gxk.26
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 12:58:29 -0800 (PST)
In-Reply-To: <4CFE9059.1080202@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant@ti.com" <sawant@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

On Tue, Dec 7, 2010 at 1:51 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> On 07/12/10 20:21, ext Paul Walmsley wrote:
>>
>> Madhusudhan,
>>
>> On my OMAP35xx BeagleBoard here, HSMMC is non-functional after retur=
ning
>> from dynamic off-mode. =A0The MMC LED turns on and stays on, and the=
 process
>> hangs, although the rest of the system still seems to run. =A0Looks =
like
>> you're listed as the maintainer for this code. =A0Do you know why th=
is is,
>> and what can be done to fix it?
>
> It is at least because omap_pm_get_dev_context_loss_count() is not
> implemented. =A0Tero Kristo was looking at that recently.
>

Yes. I agree that is the problem. In the .32 kernel I had hooked it to
"get_last_off_on_transaction_id" which helped.
But that functionality does not exist anymore. So something equivalent
to tell the driver when the OFF was hit will make it work.

Regards,
Madhu
>>
>> This is using linux-omap master at commit
>> a04fd22204b13ce34a3f8a8157f83c44d64f8da9, using omap2plus_defconfig =
with
>> DSS configured in. =A0My boot and root partitions are on MMC. =A0Fol=
lowing are
>> the commands I used to reproduce this problem.
>>
>>
>> regards
>>
>> - Paul
>>
>> echo 1> =A0/debug/pm_debug/sleep_while_idle
>> echo 1> =A0/debug/pm_debug/enable_off_mode
>> echo 5> =A0/sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
>> echo 5> =A0/sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
>> echo 5> =A0/sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>>
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
