From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: omap-twl4030: Remove ti,codec property
Date: Fri, 13 Mar 2015 12:50:56 +0100
Message-ID: <CAAfyv35r+dKtd4kia44omCo5L5ajWV+qyJ8AUjWobFas+BQFgw@mail.gmail.com>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com>
	<1426194899-14037-3-git-send-email-marek@goldelico.com>
	<38159868.RLZZTyUOlK@wuerfel>
	<5502CE9E.1020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5502CE9E.1020705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, eballetbo <eballetbo@gmail.com>, javier@dowhile0.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, jarkko.nikula@bitmer.com, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 13, 2015 at 12:48 PM, Peter Ujfalusi <peter.ujfalusi@ti.com=
> wrote:
> On 03/13/2015 01:05 PM, Arnd Bergmann wrote:
>> On Thursday 12 March 2015 22:14:59 Marek Belisko wrote:
>>> diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.t=
xt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
>>> index 1ab6bc8..656165f 100644
>>> --- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
>>> +++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
>>> @@ -4,7 +4,6 @@ Required properties:
>>>  - compatible: "ti,omap-twl4030"
>>>  - ti,model: Name of the sound card (for example "omap3beagle")
>>>  - ti,mcbsp: phandle for the McBSP node
>>> -- ti,codec: phandle for the twl4030 audio node
>>
>> As this was a required property, are you sure that no other operatin=
g system
>> uses it?
>>
>> Even if not, you should probably change it to be an optional propert=
y, so
>> that the existing dtbs do not become noncompliant after the change.
>
> After I sent my Ack, I also started to think about the same thing. It=
 is
> better to change it to optional.
OK will do and post v2. Thanks.
>
> --
> P=C3=A9ter

BR,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
