From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] ARM: dts: am335x: update USB DT references
Date: Wed, 23 Apr 2014 07:48:22 -0700
Message-ID: <20140423144822.GA4833@atomide.com>
References: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk>
 <5356794C.7070707@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53488 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751350AbaDWOsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:48:31 -0400
Content-Disposition: inline
In-Reply-To: <5356794C.7070707@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Leigh Brown <leigh@solinno.co.uk>, Mugunthan V N <mugunthanvnm@ti.com>, devicetree@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Benoit Cousson <bcousson@baylibre.com> [140422 07:14]:
> Hi Leigh,
>=20
> On 16/04/2014 13:26, Leigh Brown wrote:
> >In "ARM: dts: am33xx: correcting dt node unit address for usb", the
> >usb_ctrl_mod and cppi41dma nodes were updated with the correct regis=
ter
> >addresses.  However, the dts files that reference these nodes were n=
ot
> >updated, and those devices are no longer being enabled.
> >
> >This patch corrects the references for the affected dts files.
>=20
> Thanks for the fix. BTW, why is it a RFC? Do you plan to send an upda=
ted
> version?
>=20
> FYI, even with this fix, the BBB still does not have a working MUSB o=
n
> 3.15-rc2. Have you observed that as well?
>=20
> >Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
>=20
> If this is a final version, I'll apply it for -rc3.

Looks like I already have this in omap-for-v3.15/fixes-v2, sorry
looks like I never replied to this one.

Regards,

Tony=20
=20
> >---
> >  arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++--
> >  arch/arm/boot/dts/am335x-evm.dts          | 4 ++--
> >  arch/arm/boot/dts/am335x-evmsk.dts        | 4 ++--
> >  arch/arm/boot/dts/am335x-igep0033.dtsi    | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/bo=
ot/dts/am335x-bone-common.dtsi
> >index e3f27ec..2e7d932 100644
> >--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> >+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> >@@ -183,7 +183,7 @@
> >  &usb {
> >  	status =3D "okay";
> >
> >-	control@44e10000 {
> >+	control@44e10620 {
> >  		status =3D "okay";
> >  	};
> >
> >@@ -204,7 +204,7 @@
> >  		dr_mode =3D "host";
> >  	};
> >
> >-	dma-controller@07402000  {
> >+	dma-controller@47402000  {
> >  		status =3D "okay";
> >  	};
> >  };
> >diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am=
335x-evm.dts
> >index 28ae040..77df10d 100644
> >--- a/arch/arm/boot/dts/am335x-evm.dts
> >+++ b/arch/arm/boot/dts/am335x-evm.dts
> >@@ -331,7 +331,7 @@
> >  &usb {
> >  	status =3D "okay";
> >
> >-	control@44e10000 {
> >+	control@44e10620 {
> >  		status =3D "okay";
> >  	};
> >
> >@@ -352,7 +352,7 @@
> >  		dr_mode =3D "host";
> >  	};
> >
> >-	dma-controller@07402000  {
> >+	dma-controller@47402000  {
> >  		status =3D "okay";
> >  	};
> >  };
> >diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/=
am335x-evmsk.dts
> >index ec08f6f..ab23885 100644
> >--- a/arch/arm/boot/dts/am335x-evmsk.dts
> >+++ b/arch/arm/boot/dts/am335x-evmsk.dts
> >@@ -364,7 +364,7 @@
> >  &usb {
> >  	status =3D "okay";
> >
> >-	control@44e10000 {
> >+	control@44e10620 {
> >  		status =3D "okay";
> >  	};
> >
> >@@ -385,7 +385,7 @@
> >  		dr_mode =3D "host";
> >  	};
> >
> >-	dma-controller@07402000  {
> >+	dma-controller@47402000  {
> >  		status =3D "okay";
> >  	};
> >  };
> >diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/=
dts/am335x-igep0033.dtsi
> >index 7063311..5942e7d 100644
> >--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> >+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> >@@ -202,7 +202,7 @@
> >  &usb {
> >  	status =3D "okay";
> >
> >-	control@44e10000 {
> >+	control@44e10620 {
> >  		status =3D "okay";
> >  	};
> >
> >@@ -223,7 +223,7 @@
> >  		dr_mode =3D "host";
> >  	};
> >
> >-	dma-controller@07402000  {
> >+	dma-controller@47402000  {
> >  		status =3D "okay";
> >  	};
> >  };
> >
>=20
>=20
> --=20
> Beno=C3=AEt Cousson
> BayLibre
> Embedded Linux Technology Lab
> www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
