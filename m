From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Tue, 19 May 2009 08:49:41 +0300
Message-ID: <4A124875.1080503@nokia.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>	<20090518133241.GH3067@n2100.arm.linux.org.uk>	<87my9a8hxf.fsf@deeprootsystems.com>	<20090518170656.GJ7042@n2100.arm.linux.org.uk> <87k54e721w.fsf@deeprootsystems.com>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49866 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbZESFum (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 01:50:42 -0400
In-Reply-To: <87k54e721w.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Richard Woodruff <r-woodruff2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

Kevin Hilman wrote:
>> The problem here is that such an interface is extremely fragile.  Co=
nsider
>> what happens if a program disables HLT, and then gets killed off for=
 some
>> reason.  How does this reference get balanced again?
>>
>> I think a better solution would be a char device driver which has to=
 be
>> kept open as long as a reference is held.  When userspace closes it =
(be
>> that because the program has exited, been killed, etc) you can drop =
any
>> pending references.
>=20
> OK, this interface is not intended for users/applications. It is
> intended only for OMAP PM developers who are developing the PM code
> and want to prevent idle for various reasons during development.  It
> is not intended for productions systems.
>=20
> What about leaving /sys/power/sleep_while_idle but only if
> CONFIG_PM_DEBUG=3Dy?

Sounds like debugfs is the good place for this then.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
