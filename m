From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] arm/omap4: add twd clock to DT
Date: Sun, 18 May 2014 14:08:02 +0200
Message-ID: <CAGhQ9Vw-QaB+OnLa3yNVvD6a=XOutSZ1ejbsuUXvEcyrxEsRcQ@mail.gmail.com>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<20140418223948.GK21823@atomide.com>
	<5353F44F.5080400@xenomai.org>
	<535662F0.4080300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:51382 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaERMIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 May 2014 08:08:05 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so3262460lab.10
        for <linux-omap@vger.kernel.org>; Sun, 18 May 2014 05:08:03 -0700 (PDT)
In-Reply-To: <535662F0.4080300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

On 22 April 2014 14:39, Tero Kristo <t-kristo@ti.com> wrote:
> On 04/20/2014 07:22 PM, Gilles Chanteperdrix wrote:
>>
>> Le 19/04/2014 00:39, Tony Lindgren a =C3=A9crit :
>>>
>>> * Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [140407 1=
3:09]:
>>>>
>>>> Booting Linux 3.14 on Pandaboard currently gets the following
>>>> message displayed:
>>>>
>>>> smp_twd: clock not found -2
>>>>
>>>> Define "mpu_periphclk" as the twd clock in omap4 dts to avoid this=
=2E
>>>
>>>
>>> Tero, care to ack?
>>
>>
>> Sorry if I did not mail the right people, get_maintainer.pl gave me =
a
>> long list, and I did not feel like spamming all these people for suc=
h a
>> small patch. I do not believe Tero was in this list.
>>
>> Regards.
>
>
> Yea I don't think this is my expertise area, however the patch looks =
good to
> me, so if you really need it:
>
> Acked-by: Tero Kristo <t-kristo@ti.com>

Tony, care to add this to your omap 3.16 dt branch?

I am still getting:
[ 0.000152] smp_twd: clock not found -2

So this fix from Gilles would be nice to have.

regards
Joachim Eastwood
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
