From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Thu, 7 Feb 2013 08:58:36 +0100
Message-ID: <51135EAC.7010406@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch> <51125AFC.10704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55607 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3BGH6y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 02:58:54 -0500
In-Reply-To: <51125AFC.10704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: florian.vaussard@epfl.ch, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi,

On 02/06/2013 02:30 PM, Benoit Cousson wrote:
>> So a patch is being merged to handle triggers in the case of pwm led=
s [1].
>> When done, we will be able to add back the default trigger. Do you w=
ant
>> to wait on it to merge this series?
>=20
> What kind of dependency do we have between these two series? I mean w=
hat
> will happen if the DTS is merged before the pwm subsystem?
>=20
> If that does not generate any regression / crash, then it is OK, if n=
ot,
> we should take care of the order.

In this series the 'linux,default-trigger' property is not added to the
pwm-leds node, so it is safe to take this series.
I'm sure Florian will send the update to add this flag back for 3.10 or=
 for
3.9-rc (the needed patches for PWM and leds-pwm will be in 3.9).

I'm also waiting for 3.9-rc1 so I can finish up some of the pending thi=
ngs
regarding to PWMs.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
