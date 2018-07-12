From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board support
Date: Wed, 11 Jul 2018 22:08:19 -0500
Message-ID: <CAOCHtYhENAEiUPPzTVLDUt-eZgexEo7UqpxJg_5-Q=xTtxqtCQ@mail.gmail.com>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
 <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net> <20180711133137.GM99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711133137.GM99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2018 at 8:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Koen Kooi <koen@dominion.thruhere.net> [180711 07:36]:
>> +&cpu0_opp_table {
>> +     /*
>> +      * All PG 2.0 silicon may not support 1GHz but some of the early
>> +      * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
>> +      * to support 1GHz OPP so enable it for PG 2.0 on this board.
>> +      */
>> +     oppnitro-1000000000 {
>> +             opp-supported-hw = <0x06 0x0100>;
>> +     };
>> +};
>
> Is the above valid for new boards or should it be just
> dropped? Or is the comment just out of date?

For SanCloud, this can be dropped, they got normal 1Ghz parts from TI.

and they aren't using the Octavo SIP which didn't have the 1Ghz efuse set..

So just the normal am335x errata, nothing special required in it's dts...

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
