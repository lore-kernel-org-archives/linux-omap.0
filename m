From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Tue, 28 Feb 2012 16:59:14 -0600
Message-ID: <CAOMWX4dbufbEJpr0nTmwTHR1xz9diMBbO=khKxvMZLWrKesJRw@mail.gmail.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
 <1328723039-15952-5-git-send-email-j-pihet@ti.com> <87d38yk2e1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38027 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966122Ab2B1W7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 17:59:35 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm14so4806226wib.23
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 14:59:34 -0800 (PST)
In-Reply-To: <87d38yk2e1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 28, 2012 at 16:40, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> SmartReflex fix for erratum ID i724.
>>
>> Since OMAP's VP and PRM modules do not get reset by warm reset,
>> we should ensure that proper shutdown procedure is followed prior
>> to allowing the kernel to reboot back up.
>
> prior to reboot? =A0how?
>
> This patch only ensures a proper shutdown if the kernel goes down
> cleanly.
>
> How is this handled on reboot?
There is no known solution for watchdog resets(part of the errata WA
limitation) :( - the best we could do was to make shutdown path safe -
this includes s/w (userspace triggered) reboots.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
