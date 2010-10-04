From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Mon, 04 Oct 2010 08:44:40 -0700
Message-ID: <87wrpy0xp3.fsf@deeprootsystems.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
	<4CA9C5F6.7060902@ti.com>
	<AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
	<AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54720 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab0JDPon convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:44:43 -0400
Received: by iwn5 with SMTP id 5so7059407iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 08:44:43 -0700 (PDT)
In-Reply-To: <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com>
	(Ming Lei's message of "Mon, 4 Oct 2010 23:18:32 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Pramod <pramod.gurav@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ming Lei <tom.leiming@gmail.com> writes:

> 2010/10/4 Govindraj <govindraj.ti@gmail.com>:
>> I tried now on zoom3 with uart3[ttyO2] as console
>>
>> It boots up fine for me
>>
>> Logs:
>>
>> http://pastebin.com/sXR5nYcD
>>
>> I am using omap2plus_defconfig and lo-master
>>
>> commit 0882b1455797b0a104978000a622c3f2412e7cf5
>> Author: Tony Lindgren <tony@atomide.com>
>> Date: =A0 Fri Oct 1 17:23:48 2010 -0700
>>
>> =A0 =A0omap: READ CAREFULLY: Fix build after merging in hwmod suppor=
t for testing
>
> Seems you are trying the master branch of Tony's linux-omap-2.6 tree,=
 could you
> try the pm branch of the tree?

Why?  What do you need from the PM branch that is not in l-o master?

The PM branch is *experimental*, and is under significant change while
parts that are not yet ready for mainline are being reworked and in som=
e
cases completely re-written.

IOW, the PM branch is unstable and should not be trusted.  (I can say
that, I am the maintainer.)  ;)

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
