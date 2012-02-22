From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 13:40:03 -0600
Message-ID: <CAB-zwWjr8dG8ETX7cPHAN2fX6xJp8ofEXyU17BFHj_KqjNceuQ@mail.gmail.com>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk>
	<CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com>
	<20120222175822.GV18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:50462 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479Ab2BVTkE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 14:40:04 -0500
Received: by mail-bk0-f50.google.com with SMTP id y15so466919bkt.9
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 11:40:03 -0800 (PST)
In-Reply-To: <20120222175822.GV18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>

On Wed, Feb 22, 2012 at 11:58 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Ohad Ben-Cohen <ohad@wizery.com> [120222 01:30]:
>> + Tony, Suman
>>
>> On Wed, Feb 22, 2012 at 10:51 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > arch/arm/mach-omap2/mailbox.c: In function 'omap2_mbox_probe':
>> > arch/arm/mach-omap2/mailbox.c:354: error: 'omap2_mboxes' undeclare=
d (first use in this function)
>> > arch/arm/mach-omap2/mailbox.c:354: error: (Each undeclared identif=
ier is reported only once
>> > arch/arm/mach-omap2/mailbox.c:354: error: for each function it app=
ears in.)
>>
>> The below should trivially solve this, but I wonder if there was any
>> other merit in explicitly using CONFIG_SOC_OMAP2420 there (any
>> different between 2420 and 2430 in that respect ?).
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mai=
lbox.c
>> index 609ea2d..e61d275 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -258,7 +258,7 @@ struct omap_mbox mbox_dsp_info =3D {
>> =A0struct omap_mbox *omap3_mboxes[] =3D { &mbox_dsp_info, NULL };
>> =A0#endif
>>
>> -#if defined(CONFIG_SOC_OMAP2420)
>> +#if defined(CONFIG_ARCH_OMAP2)
>> =A0/* IVA */
>> =A0static struct omap_mbox2_priv omap2_mbox_iva_priv =3D {
>> =A0 =A0 =A0 .tx_fifo =3D {
>
> 2430 is like omap3 for the mailbox. So the code we have seems
> wrong trying to initialize it like 2420 mailbox. So we either
> need a new entry for omap2430_mboxes[], or should just bail
> out from the probe for 2430 for the fix.

Yes, current code tries to configure both mboxes in a 2430, however it
shouldn't be assigning an irq line for the iva mbox, and any request
for iva mbox should fail due to that.

Code is wrong to register both in 2430 though.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
