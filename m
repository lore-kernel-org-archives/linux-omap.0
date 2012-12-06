From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] gpio: twl4030: Correct status reporting when the GPIO
 is used as output
Date: Thu, 6 Dec 2012 11:55:00 +0100
Message-ID: <50C07984.8000003@ti.com>
References: <1354700985-4453-1-git-send-email-peter.ujfalusi@ti.com> <20121205224813.584123E0E22@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60317 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965076Ab2LFKzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Dec 2012 05:55:05 -0500
In-Reply-To: <20121205224813.584123E0E22@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 12/05/2012 11:48 PM, Grant Likely wrote:
>> -	base =3D REG_GPIODATAIN1 + d_bnk;
>> +	direction =3D gpio_twl4030_read(REG_GPIODATADIR1 + d_bnk);
>> +	if (direction > 0 && (direction >> d_off) & 0x1)
>> +		base =3D REG_SETGPIODATAOUT1 + d_bnk;
>> +	else
>> +		base =3D REG_GPIODATAIN1 + d_bnk;
>> +
>=20
> This is probably quite expensive considering that reads need to go ou=
t
> the i2c bus. Things like the output state and the pin direction shoul=
d
> be cached by the driver in its private data structure so that you don=
't
> add an additional i2c round trip.

True. I have sent the v2, which grown a bit since I did not wanted to a=
dd more
global variable to this driver.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
