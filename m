From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ALSA SoC TWL4030 driver
Date: Tue, 16 Aug 2011 17:16:01 +0300
Message-ID: <5512338.Wi2WCLqT7N@barack>
References: <5448984682E7954C9BFF27F747A9C6CA4EAEF5@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58111 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1HPOPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 10:15:48 -0400
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA4EAEF5@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 16 August 2011 15:33:09 Maximilian Schwerin wrote:
> Hi,
>=20
> I'm currently working on a beagle board clone.
>=20
> I've got some problems getting the micbias1 output on the TPS65950 to=
 work.
> I can record audio coming from a line out or if I connect micbias1 to=
 an
> extern 1.8V supply.
>=20
> /sys/devices/platform/soc-audio/TWL4030/dapm_widget shows Mic Bias 1 =
to be
> off at all times. Is there something I have to do to enable this othe=
r than
> to start recording? Or could this be a bug in the driver? Does anyone=
 have
> experience with the mic input of the TPS65950?

In your machine driver you need to connect the corresponding mic bias, =
like it=20
is done in for example for zoom2:

	/* Headset Mic: HSMIC with bias */
	{"HSMIC", NULL, "Headset Mic Bias"},
	{"Headset Mic Bias", NULL, "Headset Mic"},

Note: Beagle only have support for line-in, does your board have additi=
onal=20
inputs jack (Headset?)

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
