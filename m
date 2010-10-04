From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Mon, 04 Oct 2010 11:54:29 -0700
Message-ID: <87iq1hzt3u.fsf@deeprootsystems.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
	<4CA9C5F6.7060902@ti.com>
	<AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
	<AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com>
	<87wrpy0xp3.fsf@deeprootsystems.com>
	<AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54379 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab0JDSyc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:54:32 -0400
Received: by pzk34 with SMTP id 34so1416265pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 11:54:32 -0700 (PDT)
In-Reply-To: <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com>
	(Ming Lei's message of "Tue, 5 Oct 2010 00:17:23 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Pramod <pramod.gurav@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ming Lei <tom.leiming@gmail.com> writes:

> 2010/10/4 Kevin Hilman <khilman@deeprootsystems.com>:
>>
>> Why? =A0What do you need from the PM branch that is not in l-o maste=
r?
>
> Seems master branch works fine for me, my beagle board doesn't hang
> uart3 disabling clocks.

Master branch and PM branch have exactly the same functionality for
UART hwmods.  The problem was that you manually enabled DEBUG in
omap_hwmod.c.

> I only want to have a try of the runtime pm feature of omap3, so use
> PM branch to do the test.

master branch and PM branch have exactly the same functionality for
runtime PM

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
