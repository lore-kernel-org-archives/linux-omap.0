From: =?windows-1252?Q?Peter_K=FCmmel?= <syntheticpp@gmx.net>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 06 Jan 2015 14:47:01 +0100
Message-ID: <54ABE755.2060505@gmx.net>
References: <20150102161911.GA3298@atomide.com> <54A6E408.1090908@gmx.net> <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi> <20150102204018.GF3298@atomide.com> <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi> <20150103000220.GE3279@atomide.com> <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi> <20150105154313.GA19336@saruman> <54ABC618.8070906@gmx.net> <20150106115250.GA27539@earth.universe> <20150106124733.GE30544@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63770 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbbAFNrI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 08:47:08 -0500
Received: from [192.168.178.38] ([79.242.16.231]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MOOpx-1YDj8J0RZl-005tHD for
 <linux-omap@vger.kernel.org>; Tue, 06 Jan 2015 14:47:06 +0100
In-Reply-To: <20150106124733.GE30544@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org



Am 06.01.2015 um 13:47 schrieb Aaro Koskinen:
> Hi,
>
> On Tue, Jan 06, 2015 at 12:52:50PM +0100, Sebastian Reichel wrote:
>> On Tue, Jan 06, 2015 at 12:25:12PM +0100, Peter K=FCmmel wrote:
>>> Am 05.01.2015 um 16:43 schrieb Felipe Balbi:
>>>> Just booted AM335x with CONFIG_PREEMPT and haven't seen any proble=
m.
>>>> Perhaps this is something related to another OMAP3-only driver?
>>>> Perhaps HSI/SSI ?
>>>
>>> I see a ssi error directly before the IN-Band error:
>>>
>>> [    0.339935] platform 48058000.ssi-controller: Cannot lookup hwmo=
d 'ssi'
>>> [    0.346893] In-band Error seen by MPU  at address 0
>>> [    0.346923] ------------[ cut here ]------------
>>
>> mh I guess your board's dts included omap36xx.dtsi or omap34xx.dtsi.
>
> This log occurs also on 3630, because ssi hwmod stuff is missing from
> omap36xx_hwmod_ocp_ifs... Anyway, it's not related to this error, but=
 need
> to be added since we should get nokia-modem working also on N950/N9..=
=2E
>
> Peter: if you boot with "initcall_debug", you should see the error
> is during the DMA setup.

DMA is not a module here thus loaded before the initcall.

I've tried with CONFIG_DMADEVICES_DEBUG but then kernel didn't start at=
 all.
Absolutely no messages.
 =20
>
> A.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
