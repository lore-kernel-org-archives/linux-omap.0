From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Wed, 05 Sep 2012 14:14:31 +0300
Message-ID: <50473417.8050907@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com> <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com> <5044C2DD.5000705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51704 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753039Ab2IELOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:14:10 -0400
Received: by yenl14 with SMTP id l14so44696yen.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:14:09 -0700 (PDT)
In-Reply-To: <5044C2DD.5000705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Benoit,

On 09/03/2012 05:46 PM, Benoit Cousson wrote:
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.t=
i.com/
>=20
> Nit: 2012

Oh, I missed that (copy-paste of the header...)

>> + *
>> + * This file is licensed under the terms of the GNU General Public =
License
>> + * version 2.  This program is licensed "as is" without any warrant=
y of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +/include/ "omap2.dtsi"
>> +
>> +/ {
>> +	compatible =3D "ti,omap2420", "ti,omap2";
>> +
>> +	ocp {
>> +		mcbsp1: mcbsp@48074000 {
>> +			compatible =3D "ti,omap2420-mcbsp";
>> +			reg =3D <0x48074000 0xff>;
>> +			reg-names =3D "mpu";
>> +			interrupts =3D <0 59 0x4>, /* TX interrupt */
>> +				     <0 60 0x4>; /* RX interrupt */
>=20
> That one is not correct because it does comply with the interrupt
> controller specifier that require only one cell:
>=20
> 		intc: interrupt-controller@48200000 {
> 			compatible =3D "ti,omap2-intc";
> 			interrupt-controller;
> 			#interrupt-cells =3D <1>;
> ...
>=20
> The one you are using is for GIC IRQ controller.
> It works probably because we are using hwmod so far :-)
>=20
> Didn't you get some warning?

dtb compiles fine. I'll fix OMAP2 and OMAP3 as well.

Will send the updated series shortly.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
