From: Dima Zavin <dima@android.com>
Subject: Re: OMPA4: 3.0-rc1: Unhandled fault during insmod 'ohci-hcd.ko'
Date: Fri, 17 Jun 2011 10:55:33 -0700
Message-ID: <BANLkTimc-tfBVL__=-R4nHSSApuh+fsittK9RiGGPOyTJfQgkg@mail.gmail.com>
References: <BANLkTinYcxJqUM4G2ERew3okUTdf0LOLGA@mail.gmail.com>
	<BANLkTin=7aEaPDf=2Aa9SApdGetyvdz50g@mail.gmail.com>
	<BANLkTi=TPNWMe9_gb7SY2J62SC0L8EoRcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:52975 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380Ab1FQR4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 13:56:00 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p5HHtgLp014860
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 10:55:43 -0700
Received: from pzk2 (pzk2.prod.google.com [10.243.19.130])
	by hpaq14.eem.corp.google.com with ESMTP id p5HHtNDO028732
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 10:55:41 -0700
Received: by pzk2 with SMTP id 2so2374115pzk.37
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 10:55:36 -0700 (PDT)
In-Reply-To: <BANLkTi=TPNWMe9_gb7SY2J62SC0L8EoRcw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>, sameo@linux.intel.com
Cc: Todd Poynor <toddpoynor@google.com>, keshava_mgowda@ti.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Samuel,

Could you please push this revert to Linus (since the original got
pulled in through the mfd tree) so that 3.0 is not broken on Panda?

--DIma

On Tue, Jun 14, 2011 at 3:59 AM, Ming Lei <tom.leiming@gmail.com> wrote=
:
> Hi,
>
> 2011/6/5 Todd Poynor <toddpoynor@google.com>:
>> In general, the imprecise external abort usually means an access was=
 made to
>> registers of a module whose clock is gated. =A0The calls to clk_enab=
le()
>> within=A0usbhs_enable() probably aren't following the proper sequenc=
e of
>> ensuring the CD_L3_INIT clock domain is on (CM_L3INIT_CLKSTCTRL.CLKT=
RCTRL =3D
>> 0x2 SW_WKUP) and then the associated module slaves woken up
>> (CM_L3INIT_HSUSBHOST_CLKCTRL.MODULEMODE =3D 0x2 Enabled, similar
>> for=A0CM_L3INIT_HSUSBTLL_CLKCTRL). =A0Probably needs calls to the OM=
AP device
>> layer to set those up, but I dunno the details of this device or why=
 it
>> broke.
>>
>
> No doubt, it is caused by gated clock, ehci will be OK if revert the
> commit below:
>
> commit 7e6502d577106fb5b202bbaac64c5f1b065e6daa
> Author: Keshava Munegowda <Keshava_mgowda@ti.com>
> Date: =A0 Sun May 22 22:51:26 2011 +0200
>
> =A0 =A0mfd: Add omap-usbhs runtime PM support
>
> =A0 =A0The usbhs core driver does not enable/disable the interface an=
d
> =A0 =A0functional clocks; These clocks are handled by hwmod and runti=
me pm,
> =A0 =A0hence insted of the clock enable/disable, the runtime pm APIS =
are
> =A0 =A0used. however,the port clocks and tll clocks are handled
> =A0 =A0by the usbhs core.
>
> =A0 =A0Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> =A0 =A0Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
>
>
> --
> Ming Lei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
