From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM/dts: omap3: Fix mcbsp2/3 hwmods to be able to probe
 the drivers for audio
Date: Mon, 22 Oct 2012 13:41:02 +0200
Message-ID: <508530CE.9000703@ti.com>
References: <1350552307-10226-1-git-send-email-peter.ujfalusi@ti.com> <507FD32C.7010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41633 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab2JVLlN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 07:41:13 -0400
In-Reply-To: <507FD32C.7010108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Tony,

On 10/18/2012 12:00 PM, Benoit Cousson wrote:
> On 10/18/2012 11:25 AM, Peter Ujfalusi wrote:
>> Fixes the following errors:
>> [    2.318084] omap-mcbsp 49022000.mcbsp: invalid rx DMA channel
>> [    2.324432] omap-mcbsp 49024000.mcbsp: invalid rx DMA channel
>>
>> Which is because we failed to link the sidetone hwmod for McBSP2/3. =
The
>> missing sidetone hwmod link will prevent omap_device_alloc() to appe=
nd the
>> DMA resources since we - accidentally - end up having the same numbe=
r of
>> resources provided from DT (IO/IRQ) as we have in hwmod for the McBS=
P ports
>> without the ST resources.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Can you take this patch for -rc3?

Thanks,
P=E9ter

>=20
> Regards,
> Benoit
>=20
>> ---
>>
>> Hi Tony, Benoit,
>>
>> Can you please take this patch for 3.7 since if we boot with DT audi=
o will not
>> work on BeagleBoard and on boards which uses McBSP2 or 3 for audio.
>>
>> Thank you,
>> Peter
>>
>>  arch/arm/boot/dts/omap3.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.=
dtsi
>> index f38ea87..696e929 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -257,7 +257,7 @@
>>  			interrupt-names =3D "common", "tx", "rx", "sidetone";
>>  			interrupt-parent =3D <&intc>;
>>  			ti,buffer-size =3D <1280>;
>> -			ti,hwmods =3D "mcbsp2";
>> +			ti,hwmods =3D "mcbsp2", "mcbsp2_sidetone";
>>  		};
>> =20
>>  		mcbsp3: mcbsp@49024000 {
>> @@ -272,7 +272,7 @@
>>  			interrupt-names =3D "common", "tx", "rx", "sidetone";
>>  			interrupt-parent =3D <&intc>;
>>  			ti,buffer-size =3D <128>;
>> -			ti,hwmods =3D "mcbsp3";
>> +			ti,hwmods =3D "mcbsp3", "mcbsp3_sidetone";
>>  		};
>> =20
>>  		mcbsp4: mcbsp@49026000 {
>>
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
