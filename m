From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 01/13] hwspinlock: OMAP4: Add spinlock support in DT
Date: Mon, 10 Oct 2011 14:49:14 +0200
Message-ID: <CAK=WgbYBDPRsknBWiXP_z36bu2U_Y6GLqtCyLuj94YqJNA37mA@mail.gmail.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com> <1317055821-20652-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48999 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab1JJMtg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 08:49:36 -0400
Received: by wwf22 with SMTP id 22so9137700wwf.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 05:49:35 -0700 (PDT)
In-Reply-To: <1317055821-20652-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, grant.likely@secretlab.ca, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Benoit,

On Mon, Sep 26, 2011 at 7:50 PM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> +++ b/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
> @@ -0,0 +1,5 @@
> +* HW spinlock on OMAP4 platform:
> +
> +Required properties:
> +- compatible : Must be "ti,omap4-spinlock";
> +- ti,hwmods : "spinlock"
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.d=
tsi
> index 4c61c82..7a7f31e 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -99,5 +99,10 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x48241000 0x=
1000>,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<0x4824010=
0 0x0100>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spinlock {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
4-spinlock";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "spinlock=
";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

I think it'd be nice to add the 'baseid' property as we discussed for
dynamic allocation of hwspinlocks.

The patch that adds the hwspinlock groundwork for this is in
linux-next and will hopefully get into 3.2 if everything works out
well:

https://lkml.org/lkml/2011/9/12/194

Of course, as we discussed with Arnd, we will use phandles to the
hwspinlock controller when we'll get to static allocations of
hwspinlock instances.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
