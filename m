From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Mon, 2 Nov 2015 17:46:05 +0200
Message-ID: <5637853D.8040306@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
 <20151102100405.GJ21326@localhost> <5637534D.2020304@ti.com>
 <20151102154057.GQ21326@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151102154057.GQ21326@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Olof Johansson <olof@lixom.net>
Cc: Sekhar Nori <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Robert Schwebel <r.schwebel@pengutronix.de>, "arm@kernel.org" <arm@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Vinod,

On 11/02/2015 05:40 PM, Vinod Koul wrote:
> On Mon, Nov 02, 2015 at 02:13:01PM +0200, Peter Ujfalusi wrote:
>> Vinod,
>>
>> On 11/02/2015 12:04 PM, Vinod Koul wrote:
>>> On Mon, Nov 02, 2015 at 01:21:19AM -0800, Olof Johansson wrote:
>>>> Hi,
>>>>
>>>> 1) This seems to have broken BBB in -next for me, bisected down to=
 this patch.
>>>>
>>>> For bootlog:
>>>> http://arm-soc.lixom.net/bootlogs/next/next-20151102/bbb-arm-omap2=
plus_defconfig.html
>>>>
>>>> 2) Please avoid merging DT/platform code in your driver tree, Vino=
d,
>>>> at least without an ack from the platform maintainer. It can be a =
a
>>>> huge mess if they end up causing conflicts, so we always ask to me=
rge
>>>> the DT changes through the platform maintainer (Tony in this case)=
 by
>>>> default.
>>>
>>> I did warn when applying that I am doing so without ACK on ARM code=
, noone
>>> said a thing!
>>>
>>> I knew Tony was following the work by Peter so assumed he must have=
 been okay
>>> with it otherwise would have spoken for ~couple of weeks these were=
 in
>>> review
>>>
>>> Anyway now that we have a regression, I can revert this patch if th=
at fixes,
>>> please confirm, but might break edma... peter?
>>
>> Can you revert or drop the last two DTS patches?
>>
>> I think I will try a different route to get the split of the tpcc an=
d tptc.
>> Without the DT patches the driver will fall back to the legacy mode =
so things
>> will work in a same way they did before.
>> Or I can send a followup patch for edma.c, with that there is no nee=
d to add
>> the HWMOD_INIT_NO_IDLE to hwmod and power management looks better.
>> Basically I'm registering a 'dummy' driver for the edma3-tptc so oma=
p hwmod
>> code will not shut it down but we will keep the possibility to manag=
e the
>> power state still.
>=20
> Okay I have reverted the two and applied the edma patch sent, can you=
 please
> verify topic/edma_fix before I merge it and send my PULL request.

The branch looks good. Thank you!
It would have been great if the DTS changes for am335x/am437x would hav=
e been
in 4.4, but I will send them for 4.5 after rc1 is out.

> Would appreciate any tested-by
>=20
> Thanks
>=20


--=20
P=E9ter
