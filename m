From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 08:39:31 +0300 (EEST)
Message-ID: <20100715.083931.226798141.Hiroshi.DOYU@nokia.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<201007150648.50521.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17007 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab0GOFkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jul 2010 01:40:11 -0400
In-Reply-To: <201007150648.50521.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: marek.vasut@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Yoshiya.Hirase@nokia.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, teerth@ti.com, linux-pm@lists.linux-foundation.org

=46rom: ext Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 06:48:50 +0200

> Dne St 30. =E8ervna 2010 16:28:01 Hiroshi DOYU napsal(a):
>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>>=20
>> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>>=20
>> Based on the original work from Romit and Raghu at TI. The original
>> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>>=20
>> *1: https://patchwork.kernel.org/patch/96442/
>>=20
>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>=20
>=20
> Hey, can this also run on pre-v7 arms ? Or is there something I misse=
d that'd=20
> make that impossible?

What I verified is with OMAP3(Cortex A8) based board.

cp15 part has to be modified, but it might work without this part itsel=
f, I guess.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
