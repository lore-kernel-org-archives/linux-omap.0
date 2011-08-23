From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH v2 10/13] dt: omap4: panda board: set clock freq for
 i2c devices
Date: Wed, 24 Aug 2011 00:45:13 +0530
Message-ID: <CAC63_iTiXQUFYwyRshE7gx-MLbV4pHdbwDJCs0nSsL1H5oRwBg@mail.gmail.com>
References: <1314074021-25186-11-git-send-email-manjugk@ti.com>
	<4E537F6B.4060608@ti.com>
	<4E53F99B.3060308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56342 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755698Ab1HWTPR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 15:15:17 -0400
Received: by mail-bw0-f49.google.com with SMTP id 17so430684bke.36
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 12:15:14 -0700 (PDT)
In-Reply-To: <4E53F99B.3060308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Wed, Aug 24, 2011 at 12:33 AM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
>> From: G, Manjunath Kondaiah<manjugk@ti.com>
>> To: devicetree-discuss@lists.ozlabs.org
>> CC: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
>>
>>
>> Update omap4 panda dts file with required clock frequencies
>> for the i2c client devices existing on panda board.
>>
>> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
>> ---
>> =A0 arch/arm/boot/dts/omap4-panda.dts | =A0 16 ++++++++++++++++
>> =A0 1 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts
>> b/arch/arm/boot/dts/omap4-panda.dts
>> index c28aa95..6b831ca 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -3,4 +3,20 @@
>> =A0 / {
>> =A0 =A0 =A0 =A0model =3D "TI OMAP4 PandaBoard";
>> =A0 =A0 =A0 =A0compatible =3D "ti,omap4-panda", "ti,omap4430";
>> +
>> + =A0 =A0 =A0 i2c1 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D<400000>;
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 i2c2 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D<400000>;
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 i2c3 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D<400000>;
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 i2c4 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D<400000>;
>> + =A0 =A0 =A0 };
>> =A0 };
>
> Are you sure that this patch is setting the expected frequency?
> I see 100kHz in the boot log even with that patch.
>
> I took me some time to find the proper syntax, but in order to refere=
nce an
> existing node, you have to use &i2c1 at the top level of the file. If=
 you
> check the output of the DTC compiler, you will see the property at th=
e
> proper node.

Thanks for bringing this issue. This was one of query I have asked to g=
rant in
one of the e-mail threads. Even I noticed that, it used to fetch defaul=
t speed
instead of speed assigned in dts file. Let me check with your suggestio=
n.

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
