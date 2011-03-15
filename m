From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 3/3] OMAP PM: Add Board specific parameters for OMAP
 Volatge layer
Date: Tue, 15 Mar 2011 21:08:17 +0530
Message-ID: <AANLkTi=tss2NC569bvxVSVWftDg4kdZmiyyh5JZBZpko@mail.gmail.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com> <1300199622-32500-4-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50140 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758052Ab1COPnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 11:43:01 -0400
Received: by mail-fx0-f45.google.com with SMTP id 2so747727fxm.4
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 08:42:59 -0700 (PDT)
In-Reply-To: <1300199622-32500-4-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Mar 15, 2011 at 20:03, Vishwanath BS <vishwanath.bs@ti.com> wro=
te:
> This patch adds board specific parameters for ZOOM3 and OMAP4430 SDP =
Boards.
> The same needs to be done for other OMAP3 and OMAP4 boards once the a=
pproach
> is accepted.

Would have been great to see this info in 0/0 - what happens without
these changes on other boards?

[...]
> +union omap_volt_board_data zoom_mpu_volt_data =3D {
> + =A0 =A0 =A0 .omap3_board_data =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vdd_setup_ret =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup =A0 =A0 =A0=3D=
 OMAP3_VOLTSETUP_VDD1_RET,
I disagree this is a board specific param - the help says "setup time
of the VDDregulators in us" - seems to me that it is PMIC information

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clksetup =A0 =A0 =A0 =3D=
 OMAP3_CLKSETUP_RET,
????? why cant i just give oscillator ramp time in uSec?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup2 =A0 =A0 =A0=
 =A0 =A0 =A0 =3D 0,
why should I as  a board developer give this as well, why cant voltage
layer do addition and save me a param?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vdd_setup_off =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup =A0 =A0 =A0=3D=
 OMAP3_VOLTSETUP_VDD1_OFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clksetup =A0 =A0 =A0 =3D=
 OMAP3_CLKSETUP_OFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup2 =A0 =A0 =3D=
 OMAP3_VOLTSETUP2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltoffset =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 OMAP3_VOLTOFFSET_OFF
"offset-time to de-assert sys_offmode when exiting the OFF mode" - how
am I supposed to measure that? again - why cant voltage layer add
numbers?

> + =A0 =A0 =A0 }
> +};
> +

my overall suggestion - when I fill in board file params - I should say=
:
I use PMIC x, i have oscillator with ramp "y" uSec - the params should
talk my language as a board developers - I dont want to know indepth
details of voltage VP/VC registers and what they should contain. it is
upto voltage layer to translate, add, bit shift or do what ever is
necessary to take my board and pmic level details to register details.

Sorry, even though this is a good start for abstraction, the overall
motivation is missed, I think we need to work on it more.


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
