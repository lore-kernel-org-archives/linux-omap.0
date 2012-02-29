From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Thu, 1 Mar 2012 00:33:32 +0100
Message-ID: <CAORVsuVG-wovojojETMuPrvaFvL-fb0-t6Je+jJ8CUFn-95wig@mail.gmail.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
	<1328723039-15952-5-git-send-email-j-pihet@ti.com>
	<87d38yk2e1.fsf@ti.com>
	<CAOMWX4dbufbEJpr0nTmwTHR1xz9diMBbO=khKxvMZLWrKesJRw@mail.gmail.com>
	<878vjlfr8z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55148 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab2B2Xdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 18:33:33 -0500
Received: by vcqp1 with SMTP id p1so3864208vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 15:33:32 -0800 (PST)
In-Reply-To: <878vjlfr8z.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Jean Pihet <j-pihet@ti.com>

On Wed, Feb 29, 2012 at 7:07 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Tue, Feb 28, 2012 at 16:40, Kevin Hilman <khilman@ti.com> wrote:
>>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>>
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> SmartReflex fix for erratum ID i724.
>>>>
>>>> Since OMAP's VP and PRM modules do not get reset by warm reset,
>>>> we should ensure that proper shutdown procedure is followed prior
>>>> to allowing the kernel to reboot back up.
>>>
>>> prior to reboot? =A0how?
>>>
>>> This patch only ensures a proper shutdown if the kernel goes down
>>> cleanly.
>>>
>>> How is this handled on reboot?
>> There is no known solution for watchdog resets(part of the errata WA
>> limitation) :( - the best we could do was to make shutdown path safe=
 -
>> this includes s/w (userspace triggered) reboots.
>
> OK, then the changelog needs an update to reflect that.
Just resent patch 04/13 with the update changelog.

>
> Kevin

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
