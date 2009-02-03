From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 0/1] Do a warm reboot instead of a cold reboot
Date: Tue, 03 Feb 2009 11:50:28 +0200
Message-ID: <87hc3b4zob.fsf@trdhcp146196.ntc.nokia.com>
References: <1233594624-21615-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19340 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZBCJtZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 04:49:25 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n139mnIe026964
	for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 11:49:22 +0200
In-Reply-To: <1233594624-21615-1-git-send-email-peter.de-schrijver@nokia.com>
	(De-Schrijver Peter's message of "Mon, 2 Feb 2009 18:10:23 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>
writes:

> This patch makes arch_reset do a warm reboot instead of a cold reboot=
=2E This
> is necessary because otherwise the system does not reboot reliably wh=
en disabling
> CLKEN in retention.
>
> Note : Unfortuately this breaks retention :( IVA2, PER and CORE don't=
 go to
>        retention after reboot.

I'm not sure if fixing the problem this way makes sense
currently. This will mean that after reboot OMAP modules are not
reset. This will cause excactly this kind of problems. If we had that
code for reset all the modules on boot, situation might be different.

How about "resetting" also twl4030 in case of reboot. E.g. remove all
the scripts from the twl4030?

>
> Peter 'p2' De Schrijver (1):
>   Do a soft reboot instead of a cold boot
>
>  arch/arm/mach-omap2/prcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
