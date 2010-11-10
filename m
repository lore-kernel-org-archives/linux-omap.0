From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] omap: mailbox: add omap_device latency information
Date: Wed, 10 Nov 2010 03:18:44 +0200
Message-ID: <AANLkTikQqQNPMNQoiutf=rH3xEnKQ9hn_jXK7Oyq+zhK@mail.gmail.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-4-git-send-email-omar.ramirez@ti.com>
	<87hbfqf491.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53434 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0KJBSp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 20:18:45 -0500
Received: by bwz15 with SMTP id 15so151099bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 17:18:44 -0800 (PST)
In-Reply-To: <87hbfqf491.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

On Wed, Nov 10, 2010 at 1:48 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> =C2=A0#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_=
=46WK_MODULE)
>> +static struct omap_device_pm_latency mbox_latencies[] =3D {
>> + =C2=A0 =C2=A0 [0] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .activate_func =3D omap_=
device_enable_clocks,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .activate_lat =3D 50000,=
 /* FIXME random value */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .deactivate_func =3D oma=
p_device_enable_clocks,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .deactivate_lat =3D 5000=
0, /* FIXME random value */
>> + =C2=A0 =C2=A0 },
>> +};
>
> hmm, I'm hoping you're not expecting this to merge when using random =
values.

No, I was hoping you would comment in the RFC I sent clearly
mentioning this was an experiment 6 months ago:
http://thread.gmane.org/gmane.linux.ports.arm.omap/36745

AFAICR this was one of the first patches for hwmod, so there was not
much reference. I did see more proper ways to set those latencies
after sending that patch (automatic calculation IIRC), but I didn't
manage to work on that code again. There are more important things to
do, like getting the only user of the mailbox to actually work.

>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -53,6 +53,7 @@
>> =C2=A0#define OMAP4_MBOX_NR_REGS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(OMAP4_MBOX_REG_SIZE / sizeof(u32))
>>
>> =C2=A0static void __iomem *mbox_base;
>> +static struct platform_device *mbox_pdev;

>> + =C2=A0 =C2=A0 mbox_pdev =3D pdev;
>
> please don't use a global for this. =C2=A0What if a future SoC has mo=
re than
> one mailbox?
>
> How about adding a field to struct omap_mbox?

If you see above, there can be only one (mbox_base is already global).
So support for multiple mailboxes would be the subject of a separate
patch.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
