From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] Documentation: omap-twl4030: Remove ti,codec property
Date: Fri, 13 Mar 2015 13:48:46 +0200
Message-ID: <5502CE9E.1020705@ti.com>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com> <1426194899-14037-3-git-send-email-marek@goldelico.com> <38159868.RLZZTyUOlK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38159868.RLZZTyUOlK@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, tony@atomide.com, eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

On 03/13/2015 01:05 PM, Arnd Bergmann wrote:
> On Thursday 12 March 2015 22:14:59 Marek Belisko wrote:
>> diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.tx=
t b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
>> index 1ab6bc8..656165f 100644
>> --- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
>> +++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
>> @@ -4,7 +4,6 @@ Required properties:
>>  - compatible: "ti,omap-twl4030"
>>  - ti,model: Name of the sound card (for example "omap3beagle")
>>  - ti,mcbsp: phandle for the McBSP node
>> -- ti,codec: phandle for the twl4030 audio node
>=20
> As this was a required property, are you sure that no other operating=
 system
> uses it?
>=20
> Even if not, you should probably change it to be an optional property=
, so
> that the existing dtbs do not become noncompliant after the change.

After I sent my Ack, I also started to think about the same thing. It i=
s
better to change it to optional.

--=20
P=E9ter
