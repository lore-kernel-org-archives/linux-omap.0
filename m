From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: fix mailbox init code
Date: Thu, 23 Feb 2012 10:44:33 -0600
Message-ID: <CAB-zwWhBzbLLH7CDvUG_aaTfkMsK-iYZRG=FLHpjJQFZvYmxiA@mail.gmail.com>
References: <1329987215-28227-1-git-send-email-ohad@wizery.com>
	<B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55066 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754634Ab2BWQoe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 11:44:34 -0500
Received: by mail-lpp01m010-f41.google.com with SMTP id f4so1779086lam.28
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 08:44:33 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hdoyu@nvidia.com>

Hi,

On Thu, Feb 23, 2012 at 3:18 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> =
wrote:
> On Thu, Feb 23, 2012 at 14:23:35, Ohad Ben-Cohen wrote:
> [...]
>>
>> Which happens on CONFIG_ARCH_OMAP2 && !CONFIG_SOC_OMAP2420, due to
>> missing omap2_mboxes declaration.
>>
> [...]
>>
>> -struct omap_mbox *omap2_mboxes[] =3D { &mbox_dsp_info, &mbox_iva_in=
fo, NULL };
>> +#ifdef CONFIG_ARCH_OMAP2
>> +struct omap_mbox *omap2_mboxes[] =3D {
>> + =A0 =A0 &mbox_dsp_info,
>> +#ifdef CONFIG_SOC_OMAP2420
>> + =A0 =A0 &mbox_iva_info,
>> +#endif
>> + =A0 =A0 NULL
>> +};
>> =A0#endif
>>
>> =A0#if defined(CONFIG_ARCH_OMAP4)
>
> Instead of adding more #ifs can they be completely removed please?

I'll rebase/repost this series:

[PATCH 0/7] OMAP: mailbox: removing static declarations
http://comments.gmane.org/gmane.linux.ports.arm.omap/59620

In the meantime I would appreciate comments.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
