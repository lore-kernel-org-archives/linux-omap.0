From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] ARM: dts: twl6030: Add PWM support
Date: Tue, 22 Jan 2013 11:49:27 +0100
Message-ID: <50FE6EB7.8070605@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com> <1358519794-13214-3-git-send-email-peter.ujfalusi@ti.com> <50FE6C5E.50802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35003 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723Ab3AVKtf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 05:49:35 -0500
In-Reply-To: <50FE6C5E.50802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

HI Benoit,

On 01/22/2013 11:39 AM, Benoit Cousson wrote:
>> +
>> +	twl_pwm: pwm {
>> +		/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
>> +		compatible =3D "ti,twl6030-pwm";
>> +		#pwm-cells =3D <2>;
>> +	};
>> +
>> +	twl_pwmled: pwmled {
>> +		/* provides one PWM (id 0 for Charing indicator LED) */
>=20
> typo: charging.

Aargh. Corrected in the branch.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
