From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v5 1/4] regulator: helper routine to extract regulator_init_data
Date: Mon, 5 Dec 2011 14:40:50 +0530
Message-ID: <CAJuYYwQ-9wCu-+q0S2YYeFYemq74ULdZ-EwPGLWKHA4+0VZcsA@mail.gmail.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
	<1321615040-13257-2-git-send-email-rnayak@ti.com>
	<CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
	<20111204155433.GA16287@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59497 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1LEJKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 04:10:51 -0500
In-Reply-To: <20111204155433.GA16287@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, robherring2@gmail.com, linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

Hi Mark,

On 4 December 2011 21:24, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Dec 04, 2011 at 06:51:23PM +0530, Thomas Abraham wrote:
>
>> For regulators that are not turned on by bootloader, and which requi=
re
>> 'apply_uV' constraint, is there any alternative for turning on the
>> regulator when using dt?
>
> If the regulator isn't software managed then always_on covers this - =
the
> regulator core will enable any always_on regulators that haven't been
> enabled already.

Thanks for the hint. I was trying to deal with a regulator that was
not software managed but also required the voltage level to be set to
certain level. That was possible with 'apply_uV' constraint in non-dt
case. Anyway, I have modified the code to manage the regulator and
this works fine in dt case as well without the 'apply_uV' constraint.

>
>> =A0 =A0 =A0 /* do we need to apply the constraint voltage */
>> - =A0 =A0 if (rdev->constraints->apply_uV &&
>> - =A0 =A0 =A0 =A0 rdev->constraints->min_uV =3D=3D rdev->constraints=
->max_uV) {
>> + =A0 =A0 if ((rdev->constraints->apply_uV &&
>> + =A0 =A0 =A0 =A0 rdev->constraints->min_uV =3D=3D rdev->constraints=
->max_uV) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 (!rdev->constraints->boot_on && rdev->cons=
traints->always_on)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D _regulator_do_set_voltage(rdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 rdev->constraints->min_uV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 rdev->constraints->max_uV);
>
> I'm not sure I understand the intended logic there. =A0Voltage constr=
aints
> and enable/disable constraints are orthogonal here.

Ok. I guess the above change is incorrect then.

Thanks,
Thomas.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
