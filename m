From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex modules.
Date: Thu, 23 Dec 2010 07:25:42 -0600
Message-ID: <AANLkTi=P-3aQSk3Q2WyAAp-8WwwtxC_aOGLW+7WGd4mj@mail.gmail.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>
 <1292864437-15353-5-git-send-email-thara@ti.com> <4D133B78.5030807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37067 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751493Ab0LWN0E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 08:26:04 -0500
Received: by wyb28 with SMTP id 28so6021406wyb.39
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 05:26:02 -0800 (PST)
In-Reply-To: <4D133B78.5030807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

On Thu, Dec 23, 2010 at 06:07, Cousson, Benoit <b-cousson@ti.com> wrote=
:

>
> Please note the following log when enabling SR in Class 3 on an OMAP4=
430/sdp:
>
> [ =A0 =A02.362182] omap2_set_init_voltage: unable to find boot up OPP=
 for vdd_mpu
> [ =A0 =A02.369384] omap2_set_init_voltage: Unable to put vdd_mpu to i=
ts init voltage
> [ =A0 =A02.369384]
> [ =A0 =A02.378875] omap2_set_init_voltage: unable to find boot up OPP=
 for vdd_iva
> [ =A0 =A02.386108] omap2_set_init_voltage: Unable to put vdd_iva to i=
ts init voltage
> [ =A0 =A02.386108]
> [ =A0 =A02.396484] Power Management for TI OMAP4.
> [ =A0 =A02.401031] sr_init: No PMIC hook to init smartreflex
> [ =A0 =A02.406494] smartreflex smartreflex.0: omap_sr_probe: SmartRef=
lex driver initialized
> [ =A0 =A02.414825] smartreflex smartreflex.1: omap_sr_probe: SmartRef=
lex driver initialized
> [ =A0 =A02.423187] smartreflex smartreflex.2: omap_sr_probe: SmartRef=
lex driver initialized
> [ =A0 =A02.431732] SmartReflex Class3 initialized
>
Dumb question: how are you testing this? just boot log? or additional
patch for DVFS?


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
