From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Sun, 20 Feb 2011 22:44:37 +0530
Message-ID: <AANLkTimR-RBVF=qciWw4bn8Hu0Mzc5zQ0Bd=fSye+2Wy@mail.gmail.com>
References: <1276613548.2824.46.camel@black>
	<AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
	<1276636633.2824.88.camel@black>
	<AANLkTikJE7fNYmRqFYL9WB7z_o3GcfaDsTJ4-yZUk4od@mail.gmail.com>
	<1276726376.3211.36.camel@black>
	<AANLkTimiNPC-1PuI3D3sGs-c4FCq6UtJqZ_a6iVY_3Ci@mail.gmail.com>
	<4D5E6CB5.8080500@corscience.de>
	<AANLkTikXGhSfaXqzXWsgB=z8OKeRnUR85zAnspaALHxD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57700 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab1BTROj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Feb 2011 12:14:39 -0500
Received: by mail-qw0-f48.google.com with SMTP id 6so439147qwd.35
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 09:14:38 -0800 (PST)
In-Reply-To: <AANLkTikXGhSfaXqzXWsgB=z8OKeRnUR85zAnspaALHxD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: Mathieu Poirier <mathieu.poirier@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

On Sun, Feb 20, 2011 at 10:42 PM, S, Venkatraman <svenkatr@ti.com> wrot=
e:
>
> On Fri, Feb 18, 2011 at 6:27 PM, Thomas Weber <weber@corscience.de> w=
rote:
>>
>> Hello Mathieu, hello Venkat,
>>
>> I hope it is not too old and you remember this:
>> >
>> > =A0 This provides a good 100ms window for delays due to scheduling=
 variations.
>> > I have to still find out which section is sensitive to it.
>> > Regards,
>> > Venkat.
>> > --
>>
>> We have a custom omap3 board and use kernel 2.6.37-rc8. =A0We have t=
he
>> problem that we sometimes cannot mount our rootfs from sd-card. This
>> happens only when CONFIG_PREEMPT=3Dy. When using CONFIG_PREEMPT_NONE=
 or
>> enabling CONFIG_MMC_DEBUG everything works fine.
>>
>> The "100 ms patch" doesn't work for us. Do you found other solution(=
s)?
>>

No - I was working on some other things lately - I'll check this out th=
is week.
What type of card are you using ?
Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
