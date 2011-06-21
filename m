From: TAO HU <tghk48@motorola.com>
Subject: Re: Bug in _und_usr on dual-core ARM?
Date: Tue, 21 Jun 2011 17:37:31 +0800
Message-ID: <BANLkTinUYZm+Q3WBGLTQRXz1V2ca1AwE=g@mail.gmail.com>
References: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com>
	<20110621091529.GA22868@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:46399 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014Ab1FUJhd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 05:37:33 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p5L9YheQ015894
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 05:34:43 -0400 (EDT)
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com [209.85.210.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p5L9TYYK014289
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 05:34:43 -0400 (EDT)
Received: by mail-pz0-f42.google.com with SMTP id 37so4599337pzk.15
        for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 02:37:31 -0700 (PDT)
In-Reply-To: <20110621091529.GA22868@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, Zhou Ming-a17711 <a17711@motorola.com>

Hi, Russell

Wouldn't it lead to oops with your patch?
We're trying avoid oops actually.

On Tue, Jun 21, 2011 at 5:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 21, 2011 at 04:31:19PM +0800, TAO HU wrote:
>> Hi, All
>>
>> We got an issue on our OMAP4 SMP system.
>> Looks like __und_user(), which was triggered by a user space
>> exception, got a page fault hence lead to might_sleep() failure.
>
> Could you see whether this patch prevents the warning please.
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index bc0e1d8..d52b940 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -289,7 +289,7 @@ do_page_fault(unsigned long addr, unsigned int fs=
r, struct pt_regs *regs)
> =A0 =A0 =A0 =A0 * If we're in an interrupt or have no user
> =A0 =A0 =A0 =A0 * context, we must not take the fault..
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (in_atomic() || !mm)
> + =A0 =A0 =A0 if (in_atomic() || irqs_disabled() || !mm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto no_context;
>
> =A0 =A0 =A0 =A0/*
>
>



--=20
Best Regards
Hu Tao
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
