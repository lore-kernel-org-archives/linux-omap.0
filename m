From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/15] omap: mailbox: 2420 should be detected at run-time
Date: Fri, 14 May 2010 13:47:06 +0300
Message-ID: <AANLkTimcw0MNZdXjM6K6HJw02qlmggXqeQXHG64HYyUX@mail.gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
	 <1273772856-10881-4-git-send-email-felipe.contreras@gmail.com>
	 <4BED2326.4090302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37820 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0ENKrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 06:47:07 -0400
Received: by fxm6 with SMTP id 6so1327251fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 03:47:06 -0700 (PDT)
In-Reply-To: <4BED2326.4090302@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, May 14, 2010 at 1:17 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Felipe Contreras wrote:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/mailbox.c | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mai=
lbox.c
>> index 252e53b..6d17da8 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -431,7 +431,8 @@ err_dsp:
>> =C2=A0static int __devexit omap2_mbox_remove(struct platform_device =
*pdev)
>> =C2=A0{
>> =C2=A0#if defined(CONFIG_ARCH_OMAP2420)
>> - =C2=A0 =C2=A0 =C2=A0 omap_mbox_unregister(&mbox_iva_info);
>> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap2420())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_mbox_unregis=
ter(&mbox_iva_info);
>> =C2=A0#endif
>
> =C2=A0 Shouldn't #ifdef be remove then?

My first patch did that, but now mbox_iva_info is only available when
ARCH_OMAP2420=3Dy to save space when building for a specific OMAP.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
