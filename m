From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: remove hw_prcm module and related
	functions
Date: Sat, 1 May 2010 19:06:52 +0300
Message-ID: <n2r94a0d4531005010906zc0ca73c7sbbc9c363af673c14@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602CAF98C66@dlee06.ent.ti.com>
	 <g2p94a0d4531005010827x1fc649c0h4bcbf2f1afbccb07@mail.gmail.com>
	 <4BDC49F0.6050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51966 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0EAQGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 12:06:54 -0400
Received: by bwz19 with SMTP id 19so620195bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 09:06:52 -0700 (PDT)
In-Reply-To: <4BDC49F0.6050505@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Sat, May 1, 2010 at 6:34 PM, Nishanth Menon <menon.nishanth@gmail.co=
m> wrote:
> On 05/01/2010 10:27 AM, Felipe Contreras wrote:
>>
>> On Tue, Apr 6, 2010 at 8:54 PM, Guzman Lugo, Fernando<x0095840@ti.co=
m>
>> =C2=A0wrote:
>>>
>>> =C2=A0From 4fb9fc015cea65dcd47172a8b180f380fe86be46 Mon Sep 17 00:0=
0:00 2001
>>> From: Fernando Guzman Lugo<x0095840@ti.com>
>>> Date: Tue, 30 Mar 2010 21:37:21 -0600
>>> Subject: [PATCH] DSPBRIDGE: remove hw_prcm module and related funct=
ions
>>>
>>> This patches removes TI hw_prcm module and related functions
>>> and replace them with kernel functions. As kernel functions
>>> are exported, pointer function are used to build without
>>> problem in case of building dspbridge as a module.
>>>
>>> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
>>
>> This is screwing things for me on a beagleboard:
>>
>> mem_ext_phys_pool_init: external physical memory map failed
>
> this is interesting -> we ran out of IOremap memory??

Disregard that. I tested by recompiling only the bridgedriver but this
patch has platform changes, so the whole kernel needs to be
recompiled.

Sorry about the noise.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
