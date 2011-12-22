From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio support
Date: Thu, 22 Dec 2011 20:08:31 +0200
Message-ID: <4EF3721F.8080908@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com> <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com> <20111222173216.GJ24444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49959 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755754Ab1LVSI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 13:08:28 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id j13so5730356lah.39
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 10:08:27 -0800 (PST)
In-Reply-To: <20111222173216.GJ24444@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 12/22/2011 07:32 PM, Tony Lindgren wrote:
> Hi,
>=20
>> @@ -548,6 +588,19 @@ void omap4_panda_display_init(void)
>>  	omap_display_init(&omap4_panda_dss_data);
>>  }
>> =20
>> +static void omap4_panda_audio_init(void)
>> +{
>> +	if (cpu_is_omap4430()) {
>> +		/* PandaBoard 4430 */
>> +		panda_abe_audio_data.card_name =3D "PandaBoard";
>> +		/* Audio in is connected to HSMIC */
>> +		panda_abe_audio_data.has_hsmic =3D 1;
>> +	} else {
>> +		/* PandaBoard ES */
>> +		panda_abe_audio_data.card_name =3D "PandaBoardES";
>> +	}
>> +}
>> +
>=20
> Please move the cpu_is_omap4430() check from audio_init to..
>=20
>>  static void __init omap4_panda_init(void)
>>  {
>>  	int package =3D OMAP_PACKAGE_CBS;
>> @@ -560,6 +613,7 @@ static void __init omap4_panda_init(void)
>>  		pr_err("error setting wl12xx data\n");
>> =20
>>  	omap4_panda_i2c_init();
>> +	omap4_panda_audio_init();
>>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>>  	platform_device_register(&omap_vwlan_device);
>>  	board_serial_init();
>=20
> ..omap4_panda_init() instead and set some flag that other
> devices can use too so we don't have cpu_is_omap tests
> for each init function. I'd assume that will be needed for
> other devices too, but that's just a guess of course :)

I was planning to have omap4_panda_init_rev(), which would be called
just before the i2c_init().
If other drivers need to differentiate between Panda and PandaES they
can add their code there.

We can use GPIOs to get the board ID, I'm looking at those for a
followup patch.
The only issue is that the ID1 GPIO number is different between 4430,
and 4460 based Panda.
We can have similar revision handling as we have for Beagle at the end.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
