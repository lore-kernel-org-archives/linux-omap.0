From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] mfd: twl6040: Select i2c fast mode as default with
 regmap patch
Date: Thu, 27 Feb 2014 16:33:09 +0200
Message-ID: <530F4CA5.6030502@ti.com>
References: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com> <1393509410-1640-2-git-send-email-peter.ujfalusi@ti.com> <530F4A84.9070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaB0Od3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 09:33:29 -0500
In-Reply-To: <530F4A84.9070906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: florian.vaussard@epfl.ch, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On 02/27/2014 04:24 PM, Nishanth Menon wrote:
>=20
> we should ideally have been using highspeed for i2c bus.
>=20
> is'nt it better if i2c_check_functionality (and adding required flags
> for func) be used to check the adapter speed and decide this in the
> driver instead of hardcoding the bus speed within TWL6040 -
> considering that 6040 can infact do max high speed as well?

Yeah, I was thinking of something similar. Just did not found the API t=
o get
the speed the i2c bus has been configured to.
I'll check this.


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
