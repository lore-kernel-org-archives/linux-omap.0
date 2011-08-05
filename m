From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Support non-dcs long read
Date: Fri, 5 Aug 2011 00:17:17 -0700
Message-ID: <CAMP5XgcQCL+enaiWYX4ZLkxfpQh9UhxC8_3i3h736OET4kEGhA@mail.gmail.com>
References: <1309405483-6876-1-git-send-email-arve@android.com>
	<1312459611.2143.18.camel@deskari>
	<CAMP5XgegzAJjp8QG=Emm9TnXrn_LiVqGxTnkQ2C5_SSBbUcp7Q@mail.gmail.com>
	<1312528148.1907.13.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52988 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab1HEHRR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 03:17:17 -0400
Received: by gwaa12 with SMTP id a12so1525605gwa.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 00:17:17 -0700 (PDT)
In-Reply-To: <1312528148.1907.13.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>

2011/8/5 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On Thu, 2011-08-04 at 18:15 -0700, Arve Hj=F8nnev=E5g wrote:
>> 2011/8/4 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> > Hi,
>> >
>> > On Wed, 2011-06-29 at 20:44 -0700, Arve Hj=F8nnev=E5g wrote:
>> >> Change-Id: I18168c887e1384c07dc033a1ffc57abdacb26073
>> >> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
>> >> ---
>> >> =A0drivers/video/omap2/dss/dsi.c | =A0 =A07 ++++++-
>> >> =A01 files changed, 6 insertions(+), 1 deletions(-)
>> >
>> > This feels somehow partial... Why do you want to read generic pack=
ets if
>> > there are no functions to send generic packets?
>> >
>>
>> The chip responds with a generic packet when reading from some
>> registers. This is a simple fix while adding support for sending
>> generic packets would probably require an api change.
>
> What command do you use to read the register? DCS? If so, sounds rath=
er
> strange HW implementation.
>

This change modifies dsi_vc_dcs_read to accept a generic response
packet. If you want a separate generic read command that would also
work, but the it would make it a little harder to write the driver
since you then would need to know what type of response the chip
sends.

> If you use generic commands, for which you have support in your kerne=
l,
> I think it's better to add both write and read support at the same ti=
me.
> Adding just read support, without any way to actually use the read,
> doesn't sound sensible.
>

This change works with the existing read command. More commands can be
added later.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
