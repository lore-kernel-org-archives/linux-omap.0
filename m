From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Tue, 8 Dec 2015 09:42:26 +0200
Message-ID: <566689E2.7060907@ti.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <87wpsunn82.fsf@saruman.tx.rr.com> <20151204184706.GO23396@atomide.com>
 <5617214.abxPrpfVaF@wuerfel> <20151204215115.GP23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151204215115.GP23396-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/04/2015 11:51 PM, Tony Lindgren wrote:
> * Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [151204 13:38]:
>> On Friday 04 December 2015 10:47:07 Tony Lindgren wrote:
>>>> Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> writes:
>>>>> @@ -174,12 +182,44 @@
>>>>>             };
>>>>> =20
>>>>>             edma: edma@49000000 {
>>>>> -                   compatible =3D "ti,edma3";
>>>>> -                   ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc=
2";
>>>>> -                   reg =3D   <0x49000000 0x10000>,
>>>>> -                           <0x44e10f90 0x40>;
>>>>> +                   compatible =3D "ti,edma3-tpcc";
>>>>> +                   ti,hwmods =3D "tpcc";
>>>>> +                   reg =3D   <0x49000000 0x10000>;
>>>>> +                   reg-names =3D "edma3_cc";
>>>>>                     interrupts =3D <12 13 14>;
>>>>> -                   #dma-cells =3D <1>;
>>>>> +                   interrupt-names =3D "edma3_ccint", "emda3_mpe=
rr",
>>>>> +                                     "edma3_ccerrint";
>>>>> +                   dma-requests =3D <64>;
>>>>> +                   #dma-cells =3D <2>;
>>>>> +
>>>>> +                   ti,tptcs =3D <&edma_tptc0 7>, <&edma_tptc1 5>=
,
>>>>> +                              <&edma_tptc2 0>;
>>>>> +
>>>>> +                   ti,edma-memcpy-channels =3D /bits/ 16 <20 21>=
;
>>>>
>>>> can you explain this property here ? Are you setting bits 20 and 2=
1 on a
>>>> 16-bit field ?
>>>
>>> I think it's an arry of u16 dma channels.. But could it be just /bi=
ts/ 8
>>> instead of /bits/ 16?
>>>
>>
>> Please just drop the /bits/ 16 and use normal cells.
>=20
> Yeah agreed, makes things less confusing for sure :)

4.4 will be the first kernel where we will have the new eDMA bindings. =
I have
chosen to use 16bit array for specifying the channels used for memcpy
(ti,edma-memcpy-channels) and for the reserving paRAM slots
(ti,edma-reserved-slot-ranges). As of now we have maximum of 64 channel=
s and
512 paRAM slots. 16bit is more than enough to store this information an=
d it
even gives us enough room if ever in the future these numbers are going=
 to
increase (which  they are not).

But in order to change them to 32bit the driver needs to be changed as =
well.
Currently we do not have drivers (in 4.4) using the new bindings, 4.4 i=
s not
yet out, so it might be possible to change the binding document and the=
 driver
to use 32bit arrays. The driver internally uses 16bit type for these wh=
ich I'm
not going to change, but the code parsing the DT needs to be adjusted f=
or the
new data type.

If Vinod is willing to take update for the DT binding of eDMA for 4.4-r=
c, I
can cook up the patch(es) to do so.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
