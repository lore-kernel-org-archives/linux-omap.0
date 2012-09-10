From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/8] ARM/dts: omap2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Mon, 10 Sep 2012 14:05:25 +0300
Message-ID: <504DC975.5070609@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com> <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com> <20120907222953.GS1303@atomide.com> <504D9FBC.9030609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53737 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752480Ab2IJLEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 07:04:54 -0400
Received: by oago6 with SMTP id o6so449514oag.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 04:04:52 -0700 (PDT)
In-Reply-To: <504D9FBC.9030609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Benoit,

On 09/10/2012 11:07 AM, Benoit Cousson wrote:
> Hi Tony,
>=20
> On 09/08/2012 12:29 AM, Tony Lindgren wrote:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 04:59]:
>>> +
>>> +	ocp {
>>> +		mcbsp1: mcbsp@48074000 {
>>> +			compatible =3D "ti,omap2420-mcbsp";
>>> +			reg =3D <0x48074000 0xff>;
>>> +			reg-names =3D "mpu";
>>> +			interrupts =3D <59>, /* TX interrupt */
>>> +				     <60>; /* RX interrupt */
>>> +			interrupt-names =3D "tx", "rx";
>>> +			interrupt-parent =3D <&intc>;
>>> +			ti,hwmods =3D "mcbsp1";
>>> +		};
>>> +
>>> +		mcbsp2: mcbsp@48076000 {
>>> +			compatible =3D "ti,omap2420-mcbsp";
>>> +			reg =3D <0x48076000 0xff>;
>>> +			reg-names =3D "mpu";
>>> +			interrupts =3D <62>, /* TX interrupt */
>>> +				     <63>; /* RX interrupt */
>>> +			interrupt-names =3D "tx", "rx";
>>> +			interrupt-parent =3D <&intc>;
>>> +			ti,hwmods =3D "mcbsp2";
>>> +		};
>>> +	};
>>
>> Hmm don't you need to specify the interrupt chip and offset for
>> the interrupts here?
>=20
> Mmm, I'm not sure to get your question, there is the link to the
> interrupt-parent.
>=20
> The interrupt number is relative to the parent interrupt domain. So e=
ven
> if the INTC IRQ offset start at 32 instead of 0, DT IRQ mechanism wil=
l
> convert that to the proper hwirq thanks to irqdomain.
> In that case we should always provide interrupt number relative to th=
e
> interrupt controller HW number and not assuming any Linux IRQ number
> offset like before.
>=20
>=20
> And in fact the interrupt-parent is not even needed, by default if wi=
ll
> look to the parent to get the interrupt-controller.

This is true, but it makes the 'code' a bit more readable if I (we) spe=
cify
the interrupt-parent.

>=20
> Extract from [1]
>=20
> interrupt-parent:
> "Because the hierarchy of the nodes in the interrupt tree might not
> match the device tree, the interrupt-parent property is available to
> make the definition of an interrupt parent explicit.
> The value is the phandle to the interrupt parent. If this property is
> missing from a device, its interrupt parent is assumed to be its devi=
ce
> tree parent."
>=20
> [1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.=
0.pdf
>=20
> Regards,
> Benoit
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
