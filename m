From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc handling
Date: Thu, 16 Dec 2010 11:01:53 -0600
Message-ID: <AANLkTik6GLJkhyg0t77wQrfA6p-SmWXLFfGci0uskJ43@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
	<AANLkTinJOFMF=eC2MQB92e2XUsyyjNRRz7Bm_cyXEmp6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57530 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754825Ab0LPRB5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 12:01:57 -0500
Received: by mail-yx0-f182.google.com with SMTP id 35so1905284yxh.27
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 09:01:53 -0800 (PST)
In-Reply-To: <AANLkTinJOFMF=eC2MQB92e2XUsyyjNRRz7Bm_cyXEmp6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Dec 16, 2010 at 10:32 AM, Kanigeri, Hari <h-kanigeri2@ti.com> w=
rote:
>> @@ -130,12 +120,6 @@ static int omap2_mbox_startup(struct omap_mbox =
*mbox)
>> =A0 =A0 =A0 =A0l =3D mbox_read_reg(MAILBOX_REVISION);
>> =A0 =A0 =A0 =A0pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4,=
 (l & 0x0f));
>>
>> - =A0 =A0 =A0 if (cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D OMAP4_SMARTIDLE;
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D SMARTIDLE | AUTOIDLE;
>> - =A0 =A0 =A0 mbox_write_reg(l, MAILBOX_SYSCONFIG);
>> -
>
> The OMAP4 mailbox sysconfig register bits are laid out differently
> from previous OMAP mailbox's. Example is smart idle bit location is
> different from previous OMAPs. Can I know as how are you handling thi=
s
> aspect in hwmod code ?

hwmod framework provides definition for both IP models
(omap_hwmod_sysc_type1for omap2/3 or omap_hwmod_sysc_type2 for omap4),
these are located at arch/arm/mach-omap2/omap_hwmod_common_data.c

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
