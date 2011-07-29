From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH v3 00/13] PM QoS: add a per-device latency constraints class
Date: Fri, 29 Jul 2011 10:37:52 +0200
Message-ID: <CAORVsuVoJ5-1hx2+6+gCuuWDd9A9h_RTS=U1228BM7EYiG=gxA@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<20110728131454.GA2579@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35271 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab1G2Ihx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 04:37:53 -0400
Received: by qyk9 with SMTP id 9so2011773qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 01:37:52 -0700 (PDT)
In-Reply-To: <20110728131454.GA2579@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Mark,

On Thu, Jul 28, 2011 at 3:14 PM, mark gross <markgross@thegnar.org> wro=
te:
> On Thu, Jul 28, 2011 at 10:30:07AM +0200, jean.pihet@newoldbits.com w=
rote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch set is in an RFC state, for review and comments.
>>
>> High level implementation:
>>
=2E..

>> 7. Misc fixes to improve code readability:
>> . rename of the PM QoS implementation file from pm_qos_params.[ch] t=
o pm_qos.[ch]
> I picked the name for the file as pm_qos_params over pm_qos because I
> wanted to make it implicitly clear that this was not an full QOS
> implementation. =A0True QOS carries expectations similar to real time=
 and
> as the infrastructure is closer to "good intentioned" than even "best
> effort" and offers no notification when the QOS request is not able t=
o
> be met and really doesn't implement a true QOS at all, (it just provi=
des
> the parameter interface for part of one its missing the notification
> interface when the service level is not met and I think a few other
> things.) So I wanted to have it named a bit different from just pm_qo=
s.
>
> This said I'm not supper attached to the naming of the modules. =A0If
> folks want to change it I wouldn't complain (too much anyway;).
Ok got the idea. I do not know what name to chose though. As suggested
previously the name pm_qos_params does not reflect the implementation,
that is why I renamed it.

>
> --mark
> PS I'll look at the rest of the patches tomorrow, this time for real =
as
> I'm about to have more free time to focus on non-work stuff :)
Thanks you for reviewing!

> FWIW this write up sounds interesting.
Hope it is readable ;p

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
