From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] Support OMAP3 VC adaptation with different Power IC
Date: Thu, 25 Jun 2009 10:38:50 -0700
Message-ID: <871vp8qklx.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D546577C@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:65298 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbZFYRiu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 13:38:50 -0400
Received: by pxi28 with SMTP id 28so1178733pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 10:38:53 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D546577C@zmy16exm69.ds.mot.com> (Wang Sawsd-A's message of "Thu\, 25 Jun 2009 00\:10\:51 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>> Sent: 2009=E5=B9=B46=E6=9C=8824=E6=97=A5 8:19
>> To: Wang Sawsd-A24013
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 1/2] Support OMAP3 VC adaptation with=20
>> different Power IC
>>=20
>> "Wang Sawsd-A24013" <cqwang@motorola.com> writes:
>>=20
>> > From c1aba8ba7af3ddd16346d95795bda71e65baa4d0 Mon Sep 17=20
>> 00:00:00 2001
>> > From: Chunqiu Wang <cqwang@motorola.com>
>> > Date: Wed, 24 Jun 2009 06:48:52 +0800
>> > Subject: [PATCH] Support OMAP3 VC adaptation with different Power =
IC
>> >
>> > Current OMAP SmartReflex driver only supports TI Triton
>> > Power IC, add a callback to make it possible to use
>> > different PowerIC and use different settings to
>> > configure OMAP3 Voltage Controller for DVFS
>> >
>> > Board file can setup a new function to have different settings
>> > on SR to configure their Power IC for voltage scaling
>> >
>> > Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>>=20
>> Your patch seems wrapped again:
>>=20
>> checkpatch reports:
>>=20
>> ERROR: patch seems to be corrupt (line wrapped?)
>> #38: FILE: arch/arm/mach-omap2/smartreflex.c:57:
>> u32 value)
>>=20
>> ERROR: trailing whitespace
>> #95: FILE: arch/arm/mach-omap2/smartreflex.h:252:
>> +^I^I^I^I^I^Iu8 t_vsel, u8 c_vsel); $
>>=20
>> total: 2 errors, 0 warnings, 71 lines checked
>>=20
> Sorry about that, this time I attached these two patch files.
>

Can you please fix your mailer setup so you can resend patches inline
and get a broader review.

I suggest bypassing any mailer such as outlook and configuring
git-send-email to send them directly to an SMTP server.  If your local
SMTP is really that broken to be wrapping text, I suggest you
send via a gmail account.  This link describes how to set this
up for gmail, but also works for a local SMTP server.

  http://git.or.cz/gitwiki/GitTips#Mail

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
