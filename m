From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up
Date: Wed, 19 Nov 2008 09:20:14 +0200
Message-ID: <873ahotc5t.fsf@trdhcp146196.ntc.nokia.com>
References: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com>
	<20081118133209.GY20808@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49609 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbYKSHUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 02:20:21 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAJ7JdXt029203
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 09:20:18 +0200
In-Reply-To: <20081118133209.GY20808@gandalf.research.nokia.com> (Felipe
	Balbi's message of "Tue, 18 Nov 2008 15:32:09 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

=46elipe Balbi <felipe.balbi@nokia.com> writes:

> On Tue, Nov 18, 2008 at 03:00:37PM +0200, Jouni H=C3=B6gander wrote:
>> Currently mcspi wake-ups are not enabled. This might cause case wher=
e
>> OMAP is not waking up on mcspi events.
>>=20
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>> ---
>>  drivers/spi/omap2_mcspi.c |   11 +++++++++--
>>  1 files changed, 9 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index 454a271..4bd330c 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -59,6 +59,8 @@
>> =20
>>  /* per-register bitmasks: */
>> =20
>> +#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(0x2 << 3)
>> +#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(0x1 << 2)
>
> could you follow the convention below and use (1 << offset) ??

There aren't any convention in this driver, but I can change my patch.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
