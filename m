From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 08 Aug 2012 16:43:16 +0300
Message-ID: <50226CF4.1010202@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com> <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com> <20120808131356.GS16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:50386 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758360Ab2HHNnU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 09:43:20 -0400
Received: by yhjj63 with SMTP id j63so759378yhj.9
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 06:43:16 -0700 (PDT)
In-Reply-To: <20120808131356.GS16861@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

On 08/08/2012 04:13 PM, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 12:41:20PM +0300, Peter Ujfalusi wrote:
>=20
>> +Required properties:
>> +- compatible : must be "ti,twl4030-audio"
>=20
> So, as I mentioned before I find this sort of direct mapping of the
> Linux device representation into the device tree really troubling.
> I'm just way too aware of the fact that even the Linux split of these
> things can change over time and often represents internal Linux
> considerations.

Yes, I remember. This is however a bit different case compared to the t=
wl6040.
The twl4030 series of PMIC includes the following parts:
twl4030, twl5030, twl5031, tps65950, tps65930 - contains audio block
tps65920, tps65921 - does not contain audio block

So the audio block within these PMICs are really a block, it is present=
 on
some PMIC and it is missing on other's.

This is what we discussed regarding to twl6040. I only expose the audio=
 block
and not the Linux implementation (that we have separate driver for vibr=
a and
codec sub functionality).

>> +-ti,hs_extmute: Use external mute for HS pop reduction
>> +-ti,hs_extmute_gpio: Use external GPIO to control the external mute
>> +-ti,hs_extmute_disable_level: The desired level of the GPIO line wh=
en the
>> +			      external mute is disabled. valuse: 0 or 1
>=20
> This doesn't seem like something that should be in the CODEC driver
> really, there's a general need for something which can unmute control=
s
> at the end of the power up sequence and mute before power down.  Also=
,
> if this is going to be part of the binding shouldn't we just omit the
> first property and simply check for the presence of the property whic=
h
> specifies the GPIO?

The hs_extmute is used for reducing pop noise on the headset. The seque=
nce is
described in the TRM and it need to be done within the codec driver sin=
ce it
is within the sequence.
Now there's two ways for boards to implement it:
using the dedicated pin from twl4030 PMIC (MUTE/GPIO6) - if only
"ti,hs_extmute" present we use this mode.
Some boards are using the GPIO6 from twl4030 for other purposes, in thi=
s case
an external GPIO is used for the same purpose - thus we have
ti,hs_extmute_gpio and ti,hs_extmute_disable_level to tell the driver t=
his.
As for the ti,hs_extmute_disable_level: some boards chosen that the mut=
e is
disabled when the signal is high on the GPIO (don't ask me why). This p=
roperty
tells this.

All of this has to be in the driver due to the sequencing requirements.

>=20
>> +#ifdef CONFIG_OF
>> +	if (of_find_node_by_name(node, "codec"))
>> +		return true;
>> +#endif
>=20
> This really seems like we should be stubbing out of_find_node_by_name=
()
> to return false in non-OF cases.

Yes, most likely the of_find_node_by_name() deserves the same treatment=
 as
some selected of_* function in case CONFIG_OF is not selected.
But at the moment this is not the case, we need to protect with ifdef s=
ince we
might break other randconfigs where CONFIG_OF is not set.

>> +#ifdef CONFIG_OF
>> +	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibr=
a)
>> +		return true;
>> +#endif
>=20
> Similarly here.

Here the ifdef is no needed. of_property_read_u32() return -ENOSYS in c=
ase
CONFIG_OF is not selected.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
