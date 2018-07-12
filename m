From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Thu, 12 Jul 2018 12:20:04 +0200
Message-ID: <E23BA518-A33A-418D-B539-55345F1DC517@dominion.thruhere.net>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
 <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net>
 <20180711133137.GM99251@atomide.com>
 <CAOCHtYhENAEiUPPzTVLDUt-eZgexEo7UqpxJg_5-Q=xTtxqtCQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOCHtYhENAEiUPPzTVLDUt-eZgexEo7UqpxJg_5-Q=xTtxqtCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



> Op 12 jul. 2018, om 05:08 heeft Robert Nelson =
<robertcnelson@gmail.com> het volgende geschreven:
>=20
> On Wed, Jul 11, 2018 at 8:31 AM, Tony Lindgren <tony@atomide.com> =
wrote:
>> * Koen Kooi <koen@dominion.thruhere.net> [180711 07:36]:
>>> +&cpu0_opp_table {
>>> +     /*
>>> +      * All PG 2.0 silicon may not support 1GHz but some of the =
early
>>> +      * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
>>> +      * to support 1GHz OPP so enable it for PG 2.0 on this board.
>>> +      */
>>> +     oppnitro-1000000000 {
>>> +             opp-supported-hw =3D <0x06 0x0100>;
>>> +     };
>>> +};
>>=20
>> Is the above valid for new boards or should it be just
>> dropped? Or is the comment just out of date?
>=20
> For SanCloud, this can be dropped, they got normal 1Ghz parts from TI.
>=20
> and they aren't using the Octavo SIP which didn't have the 1Ghz efuse =
set..
>=20
> So just the normal am335x errata, nothing special required in it=E2=80=99=
s dts...

Thanks for the info! I=E2=80=99ll send a v3 with that bit removed =
shortly after I figure out what trips up kbuild.

regards,

Koen=
