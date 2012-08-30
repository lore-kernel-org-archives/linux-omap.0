From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/3] MFD/GPIO: Add twl6040 GPO driver
Date: Thu, 30 Aug 2012 12:16:11 +0300
Message-ID: <503F2F5B.6020304@ti.com>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:38214 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab2H3JP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 05:15:59 -0400
Received: by obbuo13 with SMTP id uo13so2799731obb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 02:15:57 -0700 (PDT)
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Samuel, Linus,

On 08/16/2012 03:13 PM, Peter Ujfalusi wrote:
> Hello,
>=20
> Changes since v1:
> - Removed the ti,use-gpo property from DT bindings
> - Register the GPO driver if we booted with DT blob or in legacy if t=
he pdata
>   for the GPO driver is present
> - DT binding Documentation update
>=20
> The Documentation update has reference to the twl6040.dtsi file which=
 will be
> created to hold the common/static properties for the twl6040.
> To avoid cross tree merge issues later I have only included the Docum=
entation
> update to this series and I will send the actual .dtsi/.dts changes v=
ia
> linux-omap. If this is not a problem.

Did you had time to look at this series? Do you want me to resend it?

Thank you,
P=E9ter

>=20
> The dependencies for this series are in mainline and I think this ser=
ies can
> go via GPIO if Samuel agrees with the changes.
>=20
> Intro mail from v1:
>=20
> The following series adds support for the GPO (General Purpose Output=
) on the
> twl6040/41 audio chip.
> The series has been tested on SDP4430, compile tested for x86_64 and =
x86_32 bit
> to be sure it does not introduce build breakage.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   mfd: twl6040: Fix GPO mask
>   mfd: twl6040: Add twl6040-gpio child
>   gpio: Add basic support for TWL6040 GPOs
>=20
>  Documentation/devicetree/bindings/mfd/twl6040.txt |    9 +-
>  drivers/gpio/Kconfig                              |    7 +
>  drivers/gpio/Makefile                             |    1 +
>  drivers/gpio/gpio-twl6040.c                       |  137 +++++++++++=
++++++++++
>  drivers/mfd/twl6040-core.c                        |   15 +++
>  include/linux/mfd/twl6040.h                       |   11 ++-
>  6 files changed, 175 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/gpio/gpio-twl6040.c
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
