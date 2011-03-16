From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [RFC][PATCH 3/3] OMAP PM: Add Board specific parameters for OMAP
 Volatge layer
Date: Wed, 16 Mar 2011 11:23:50 +0530
Message-ID: <a26582240fc72e0a79d7af99b40179cb@mail.gmail.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
 <1300199622-32500-4-git-send-email-vishwanath.bs@ti.com> <AANLkTi=tss2NC569bvxVSVWftDg4kdZmiyyh5JZBZpko@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:35543 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165Ab1CPFxv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 01:53:51 -0400
Received: by vws18 with SMTP id 18so1416308vws.12
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 22:53:50 -0700 (PDT)
In-Reply-To: <AANLkTi=tss2NC569bvxVSVWftDg4kdZmiyyh5JZBZpko@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Menon, Nishanth [mailto:nm@ti.com]
> Sent: Tuesday, March 15, 2011 9:08 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC][PATCH 3/3] OMAP PM: Add Board specific parameters
> for OMAP Volatge layer
>
> On Tue, Mar 15, 2011 at 20:03, Vishwanath BS
> <vishwanath.bs@ti.com> wrote:
> > This patch adds board specific parameters for ZOOM3 and OMAP4430
> SDP Boards.
> > The same needs to be done for other OMAP3 and OMAP4 boards once
> the approach
> > is accepted.
>
> Would have been great to see this info in 0/0 - what happens without
> these changes on other boards?
Ok will fix it.
>
> [...]
> > +union omap_volt_board_data zoom_mpu_volt_data =3D {
> > + =A0 =A0 =A0 .omap3_board_data =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vdd_setup_ret =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup =A0 =A0 =A0=
=3D OMAP3_VOLTSETUP_VDD1_RET,
> I disagree this is a board specific param - the help says "setup time
> of the VDDregulators in us" - seems to me that it is PMIC information
Yes. This should be PMIC parameter. Thanks for catching it.
>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clksetup =A0 =A0 =A0=
 =3D OMAP3_CLKSETUP_RET,
> ????? why cant i just give oscillator ramp time in uSec?
Clksetup =3D PRM_VOLTOFFSET + PRM_VOLTSETUP2.. So it is not just oscill=
ator
ramp time.

>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup2 =A0 =A0 =A0=
 =A0 =A0 =A0 =3D 0,
> why should I as  a board developer give this as well, why cant voltag=
e
> layer do addition and save me a param?
Do you want to give 5 other parameters just to save one parameter?
=46rom the patch, it is very clear how this parameter is calculated. Bo=
ard
developer just needs to change the values of other required parameters =
and
this parameter is automatically calculated.
>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vdd_setup_off =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup =A0 =A0 =A0=
=3D OMAP3_VOLTSETUP_VDD1_OFF,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clksetup =A0 =A0 =A0=
 =3D OMAP3_CLKSETUP_OFF,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltsetup2 =A0 =A0 =3D=
 OMAP3_VOLTSETUP2,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltoffset =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 OMAP3_VOLTOFFSET_OFF
> "offset-time to de-assert sys_offmode when exiting the OFF mode" - ho=
w
> am I supposed to measure that? again - why cant voltage layer add
> numbers?
It is not question of mathematical computation here. There are the
parameters that have to be measured manually to find the actual delay.
If your concern is lack of documentation on how to measure it, I can
provide relevant links.
>
> > + =A0 =A0 =A0 }
> > +};
> > +
>
> my overall suggestion - when I fill in board file params - I should s=
ay:
> I use PMIC x, i have oscillator with ramp "y" uSec - the params shoul=
d
> talk my language as a board developers - I dont want to know indepth
> details of voltage VP/VC registers and what they should contain. it i=
s
> upto voltage layer to translate, add, bit shift or do what ever is
> necessary to take my board and pmic level details to register details=
=2E
>
> Sorry, even though this is a good start for abstraction, the overall
> motivation is missed, I think we need to work on it more.
The motivation here is to enable different kinds of PMIC and Boards to
work with OMAP Voltage layer (and not just board file params).

=46or your concern on board file abstraction, I do not think there are
magical formulae to calculate all these parameters based on one paramet=
er.

Some have to be measured manually and probably documentation would help=
 as
to how and what to measure. Pls let me know if you have any such formul=
ae
to calculate these parameters.
Also note that these board file params are required only for OMAP3.

Vishwa
>
>
> Regards,
> Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
