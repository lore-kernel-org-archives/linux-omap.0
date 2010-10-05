From: Pramod <pramod.gurav@ti.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 15:28:12 +0530
Message-ID: <4CAAF6B4.4030708@ti.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com> <4CA9C5F6.7060902@ti.com> <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com> <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com> <87wrpy0xp3.fsf@deeprootsystems.com> <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com> <87iq1hzt3u.fsf@deeprootsystems.com> <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com> <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com> <4CAACFFF.9040702@ti.com> <alpine.DEB.2.00.1010050117390.13816@utopia.booyaka.com> <4CAAF126.5080206@ti.com> <alpine.DEB.2.00.1010050346130.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44274 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772Ab0JEJ6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 05:58:09 -0400
In-Reply-To: <alpine.DEB.2.00.1010050346130.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 05 October 2010 03:17 PM, Paul Walmsley wrote:
> On Tue, 5 Oct 2010, Pramod wrote:
>
>> On Tuesday 05 October 2010 12:49 PM, Paul Walmsley wrote:
>>> On Tue, 5 Oct 2010, Pramod wrote:
>>>
>>>> I applied this patch on my kernel which is based on android-2.6.32
>>>> enabling
>>>> dynamic printks. I still see the console hang after enabling the logs in
>>>> hwmod.
>>>>
>>>> I am using zoom3 board. Can you please let me know which defconfig from lo
>>>> master branch can be used to test on zoom3? I would like to test this
>>>> patch
>>>> with lo master branch and zoom3.
>>>
>>> Could you please paste your boot log messages here?
>>>
>>>
>>> - Paul
>>
>> Hi paul,
>> These are the boot log messages.
>
> Is that with the patch applied or without it?  If without, please post the
> log messages from a boot after you apply the patch.
>
> - Paul

These logs are with the patch shared by you.

Pramod

