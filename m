From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2] twl4030: Fix boot with twl4030 usb transceiver
 enabled
Date: Thu, 01 Oct 2009 11:36:29 +0300
Message-ID: <1254386189.32310.20.camel@localhost>
References: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54177 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbZJAIgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 04:36:37 -0400
In-Reply-To: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: sameo@linux.intel.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 2009-10-01 at 11:25 +0300, Roger Quadros wrote:
>  	if (twl_has_bci() && pdata->bci && !(features & TPS_SUBSET)) {
>  		child =3D add_child(3, "twl4030_bci",
> @@ -532,16 +531,61 @@ add_children(struct twl4030_platform_data *pdat=
a, unsigned long features)
>  	}
> =20
>  	if (twl_has_usb() && pdata->usb) {
> +
Why is this extra line?

> +		static struct regulator_consumer_supply usb1v5 =3D {
> +			.supply =3D	"usb1v5",
> +		};

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
