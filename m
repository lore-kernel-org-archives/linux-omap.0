From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Wed, 29 Feb 2012 10:07:08 -0800
Message-ID: <878vjlfr8z.fsf@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
	<1328723039-15952-5-git-send-email-j-pihet@ti.com>
	<87d38yk2e1.fsf@ti.com>
	<CAOMWX4dbufbEJpr0nTmwTHR1xz9diMBbO=khKxvMZLWrKesJRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:44148 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964975Ab2B2SHR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 13:07:17 -0500
Received: by pbcuo5 with SMTP id uo5so2642696pbc.16
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 10:07:11 -0800 (PST)
In-Reply-To: <CAOMWX4dbufbEJpr0nTmwTHR1xz9diMBbO=khKxvMZLWrKesJRw@mail.gmail.com>
	(Nishanth Menon's message of "Tue, 28 Feb 2012 16:59:14 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Jean Pihet <j-pihet@ti.com>

"Menon, Nishanth" <nm@ti.com> writes:

> On Tue, Feb 28, 2012 at 16:40, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> From: Nishanth Menon <nm@ti.com>
>>>
>>> SmartReflex fix for erratum ID i724.
>>>
>>> Since OMAP's VP and PRM modules do not get reset by warm reset,
>>> we should ensure that proper shutdown procedure is followed prior
>>> to allowing the kernel to reboot back up.
>>
>> prior to reboot? =C2=A0how?
>>
>> This patch only ensures a proper shutdown if the kernel goes down
>> cleanly.
>>
>> How is this handled on reboot?
> There is no known solution for watchdog resets(part of the errata WA
> limitation) :( - the best we could do was to make shutdown path safe =
-
> this includes s/w (userspace triggered) reboots.

OK, then the changelog needs an update to reflect that.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
