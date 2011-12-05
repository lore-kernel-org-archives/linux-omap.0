From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Mon, 05 Dec 2011 15:45:04 +0200
Message-ID: <4EDCCAE0.2000009@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com> <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com> <20111203112206.GE6043@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45099 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932135Ab1LENpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 08:45:01 -0500
Received: by mail-ey0-f175.google.com with SMTP id c1so501015eaa.20
        for <linux-omap@vger.kernel.org>; Mon, 05 Dec 2011 05:45:00 -0800 (PST)
In-Reply-To: <20111203112206.GE6043@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 12/03/2011 01:22 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:
>=20
>> @@ -0,0 +1,13 @@
>> +* Texas Instruments OMAP4 Digital Microphone Module
>> +
>> +Required properties:
>> +  - compatible : "ti,omap4-dmic"
>> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most =
case
>> +		 it is "dmic".
>=20
> Actually thinking about this some more I think what's concerning me i=
s
> the documentation as much as anything else - if it was just an intern=
al,
> unpublished interface of the OMAP core code which happened to use dev=
ice
> tree I probably wouldn't have worried about it churning.

Actually it is documented here:
Documentation/devicetree/bindings/arm/omap/omap.txt

In order to move all OMAP drivers to DT - as Benoit already mentioned -
we need additional work in DT.
At this point of time if we add the DT representation we anyways need t=
o
change it as the core will receive the features, and we still need to
fall back to hwmod to get the drivers working.
As soon as we can migrate away from the hwmod we will do, but having
this in place helps us to migrate other parts to DT.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
