From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 23 Dec 2011 16:30:42 +0800
Message-ID: <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
	<CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
	<CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
	<CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
	<CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53145 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab1LWIan convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Dec 2011 03:30:43 -0500
Received: by pbdu13 with SMTP id u13so4013817pbd.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Dec 2011 00:30:43 -0800 (PST)
In-Reply-To: <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Shilimkar,

Sorry for the delay.

On Mon, Dec 19, 2011 at 2:17 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:

> The patches are fine but I am surprised that 'dyndep.patch' is helpin=
g you.
> L3_2 dependency is always enabled with ISS or Camera and it
> should have worked.
> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm), shoudn't do anything since
> the bit is read-only.

Yes, you are right. After some investigating, I found that
clkdm_add_wkdep(iss_clkdm, l3_2_clkdm) returns failure, so clkdms_setup
is bypassed and the issue is avoided.

>
> Can you check value of CM_CAM_STATICDEP [ 0x4A009004],

The value is 0x40 after and before the patch.

> after your patch. I am suspecting that for some reason l3_1 dep.
> is getting enabled which might be helping your case.

Seems no changes after adding clkdm_add_wkdep(iss_clkdm, l3_1_clkdm)
on the problem.

The only change on iss(CAM) clock domain setting in your commit[1] is t=
o
configure CLKTRCTRL as HW_AUTO, instead of previous  SW_WKUP.
Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
fixed, so I am wondering if something is wrong about HW_AUTO mode
of CAM clock domain.


--=A0Ming Lei

[1],  ARM: OMAP4: PM: Initialise all the clockdomains to supported stat=
es

[2],  diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..1dfc7ce 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -359,7 +359,7 @@ static struct clockdomain iss_44xx_clkdm =3D {
        .clkdm_offs       =3D OMAP4430_CM2_CAM_CAM_CDOFFS,
        .wkdep_srcs       =3D iss_wkup_sleep_deps,
        .sleepdep_srcs    =3D iss_wkup_sleep_deps,
-       .flags            =3D CLKDM_CAN_HWSUP_SWSUP,
+       .flags            =3D CLKDM_CAN_SWSUP,
 };
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
