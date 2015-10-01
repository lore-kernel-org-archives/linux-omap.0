From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Thu, 1 Oct 2015 08:57:40 +0300
Message-ID: <560CCB54.60306@ti.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
 <560BB434.6080308@ti.com> <560BDCF8.20909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <560BDCF8.20909@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/30/2015 04:00 PM, Tero Kristo wrote:
>>>> +/* l4_per2 -> mcasp3 */
>>>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
>>>> +    .master        =3D &dra7xx_l4_per2_hwmod,
>>>> +    .slave        =3D &dra7xx_mcasp3_hwmod,
>>>
>>> So this is the low-speed control/register access port, where the MP=
U
>>> writes to the McASP3 config registers...
>>>
>>>> +    .clk        =3D "l3_iclk_div",
>>>
>>> ... and thus this interface clock doesn't look right for this port,=
 since
>>> it's most likely generated from the L4PER2, where this port is conn=
ected.
>>> So it should probably be "l4_iclk_div".
>>
>> There is no "l4_iclk_div" for dra7xx. Looking around the file all ot=
her script
>> generated data uses "l3_iclk_div" for IPs under dra7xx_l4_per2_hwmod=
=2E
>>
>> Tero: do you know the reason for this?
>=20
> This comes from the autogen generated data. Looking at the hwdb data =
for dra7,
> it seems l3 clock is defined as the OCP input clock for most of the m=
odules.
>=20
> Looking at TRM, we also have L3 ICK defined as the interface clock fo=
r GPIO
> modules for example, and also mcasp modules.
>=20
> I think this is just a documentation issue and we are missing a divid=
e by 2
> from all interface clocks, the interface clocks are coming from l4
> interconnects and the interconnect chapter still clearly states that =
the l4
> clock is l3 clock / 2.

It seams that we have the clock node for the l4_iclk_div, but it is cal=
led as
l4_root_clk_div.

I will use this in the mcasp3 hwmod patch.

--=20
P=E9ter
