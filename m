From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 31 Jan 2015 16:13:39 +0100
Message-ID: <CAALWOA9jXeUgOj=GWFVQKkaz_Goxj-NOKk5qRHUTF6=EXEu+6w@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <201501171829.18354@pali>
 <20150117174125.GV18552@atomide.com> <201501311234.41001@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:38769 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbAaPOB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 10:14:01 -0500
Received: by mail-we0-f182.google.com with SMTP id l61so31824094wev.13
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 07:14:00 -0800 (PST)
In-Reply-To: <201501311234.41001@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

On 31 January 2015 at 12:34, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> [  172.923553] Unhandled fault: external abort on non-linefetch (0x10=
18) at 0xb6f87028
> [  172.930664] In-band Error seen by MPU  at address 0

Also, why is this error so uninformative?  A synchronous abort should
at least mention the _physical_ address, type of access, etc.

Anyhow, since checking the firewalls/APs to see if you have permission
will probably only get you yet another fault if things are walled off,
the robust way of dealing with this sort of situation is by probing
the device with a read while trapping bus faults. This also handles
modules that are unreachable for other reasons, e.g. being disabled by
eFuse.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
