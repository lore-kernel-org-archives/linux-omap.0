From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 6/7] arm: omap4: support pmu
Date: Fri, 25 Nov 2011 08:37:05 +0800
Message-ID: <CACVXFVPE0pt2shERtAvn9bU2Mtg_xcuV0g3agexxPRYRHpfZvw@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-7-git-send-email-ming.lei@canonical.com>
	<CAH+eYFD==CbcTWha=4pLVaaeE32gN4_BPdKv0Eo-XNhiz8CM-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58275 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab1KYAhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Nov 2011 19:37:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RTjms-0000d7-Vt
	for linux-omap@vger.kernel.org; Fri, 25 Nov 2011 00:37:07 +0000
Received: by yenl6 with SMTP id l6so648876yen.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Nov 2011 16:37:05 -0800 (PST)
In-Reply-To: <CAH+eYFD==CbcTWha=4pLVaaeE32gN4_BPdKv0Eo-XNhiz8CM-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, Woodruff Richard <r-woodruff2@ti.com>

Hi,

On Thu, Nov 24, 2011 at 1:47 AM, Rabin Vincent <rabin@rab.in> wrote:
> On Mon, Oct 24, 2011 at 20:15, =A0<ming.lei@canonical.com> wrote:
>> =A0static struct platform_device* __init omap4_init_pmu(void)
>> =A0{
>> =A0 =A0 =A0 =A0int id =3D -1;
>> @@ -420,6 +472,10 @@ static struct platform_device* __init omap4_ini=
t_pmu(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 omap4_pmu_data.handle_irq =3D omap4_pmu_handler;
>> + =A0 =A0 =A0 omap4_pmu_data.enable_irq =3D omap4_enable_cti;
>> + =A0 =A0 =A0 omap4_pmu_data.disable_irq =3D omap4_disable_cti;
>> +
>> =A0 =A0 =A0 =A0pd =3D omap_device_build_ss(dev_name, id, oh, 3, &oma=
p4_pmu_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeo=
f(omap4_pmu_data),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_=
pmu_latency,
>> @@ -440,7 +496,9 @@ static void __init omap_init_pmu(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pd =3D omap4_init_pmu();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!pd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_enable(pd);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_enable(&od->pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_configure_pmu_irq();
>
> This doesn't build, because there's no "od" in this function. =A0I gu=
ess
> you shouldn't be changing the omap_device_enable() call.

Yes, you are right. Looks like this version is against linus tree, and
I have another version against -next tree, which uses the latest
'debugss' module and will be sent out later.


thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
