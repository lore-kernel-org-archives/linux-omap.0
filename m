From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 7/7] omap: mailbox: remove unreachable return
Date: Sun, 7 Nov 2010 09:18:03 -0600
Message-ID: <AANLkTi=rCBxRvxP6+6Mn0CmUwSO+uCFqyPDMx+AGnx2-@mail.gmail.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-8-git-send-email-omar.ramirez@ti.com>
	<4CD59CB3.2060306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50729 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab0KGPSF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 10:18:05 -0500
Received: by mail-iw0-f175.google.com with SMTP id 42so5000381iwn.6
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 07:18:04 -0800 (PST)
In-Reply-To: <4CD59CB3.2060306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 1:21 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
>>
>> Remove unreachable return statement.
>>
>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/mailbox.c | =A0 =A02 --
>> =A01 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mai=
lbox.c
>> index 5e9ea0f..335eb2b 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -434,8 +434,6 @@ static int __devinit omap2_mbox_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>> =A0 =A0 =A0 =A0}
>
> Please add a blank line here.

ok...

>
> Otherwise you can add: Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
