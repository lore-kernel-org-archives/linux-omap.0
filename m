From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 10/11] ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8
Date: Thu, 3 Mar 2016 13:13:13 +0200
Message-ID: <56D81C49.6030706@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
 <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
 <56D5C6B1.6040005@ti.com>
 <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 03/01/2016 07:01 PM, Paul Walmsley wrote:
>>> 2. The patch sets HWMOD_SWSUP_SIDLE for McASP1 and 2, but doesn't s=
et it=20
>>> for McASP4-8.  Could you please confirm that this is intentional, a=
nd if=20
>>> so, why?  The descriptions of the MODULEMODE fields in SPRUHZ6 look=
=20
>>> identical.
>>
>> I need to confirm this, but all McASP should have the same set of fl=
ags.
>=20
> OK.  Looking at McASP3 data this morning, they probably shouldn't nee=
d=20
> HWMOD_SWSUP_SIDLE, but probably all need=20
>=20
>                         .modulemode   =3D MODULEMODE_SWCTRL,
>=20
>>> 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should=
 be=20
>>> "dra7xx_mcasp1__l3_main_1"-style links to indicate this.
>>
>> I need to check this, but I don't think McASP1,2,3 can be bus-master=
 onto L3.
>=20
> OK.  When you get back, maybe doublecheck this - it looks to me from=20
> SPRUHZ6 that McASP1-3 have built-in DMA controllers.

They are only targets on L3. Not sure about the built-in DMA controller

>=20
>> I can resend the series next week as I'm out of office this week.
>=20
> That's fine.  It's most likely v4.7 material at this point.
>=20
>=20
> - Paul
>=20


--=20
P=C3=A9ter
