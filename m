From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PM Questions
Date: Thu, 17 Mar 2011 13:40:20 +0100
Message-ID: <AANLkTimnUYZY8AeU0WJKWXz9CvfPH0gNJPnKC2gj8W7F@mail.gmail.com>
References: <AANLkTinoW69jLYpRoGU+bSXr=0x7GFGyJmr4Nj4GSDzL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59209 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab1CQMkV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Mar 2011 08:40:21 -0400
Received: by qyk7 with SMTP id 7so4301242qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 05:40:20 -0700 (PDT)
In-Reply-To: <AANLkTinoW69jLYpRoGU+bSXr=0x7GFGyJmr4Nj4GSDzL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marshall Crocker <maroc81@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Mar 16, 2011 at 8:31 PM, Marshall Crocker <maroc81@gmail.com> w=
rote:
> Hi all,
>
> I have a few questions about PM functionality I would be grateful if
> someone could answer.
>
> I'm trying to reduce power on a gumstix overo COM with the latest
> 2.6.38 pm kernel branch up and running,=A0 I've enabled sleep while i=
dle
> and "off" mode along with serial timeouts and I do in fact see a majo=
r
> drop in power consumption when it hits idle/off mode.
>
> 1) Should the "mem" power state reduce power further?=A0 Or does that
> simply force the omap into the same states achieved by sleep while
> idle and off mode enabled?=A0 I'm not seeing any less power in "mem"
> state versus idle/off state.
No the resulting power savings are the same. 'mem' is just a forced
suspend state while idle tries to reach the lowest power state
dynamically.

> 2)=A0 I saw from earlier emails that DVFS is currently disabled.=A0 W=
ould
> I see any power additional power savings with DVFS?=A0 Obviously, pow=
er
> would be reduced if I ran a governor such as on demand so that waking
> up from idle doesn't use full speed unless needed.=A0 Are there any
> other benefits?=A0 Should I wait for DVFS to be merged back in to PM =
or
> apply the patches that are waiting for approval?
The patches are not yet merged in. Of course you can apply them locally=
=2E

> 3) Are peripherals such as SPI, I2C, etc disabled when in idle/off
> mode?=A0 I'm coming from a microcontroller background where disabling
> unused peripherals can save power.=A0 Is that true for the omap?
Yes all peripherals are dynamically put in the lowest power mode possib=
le.

> 4) Any additional power saving tips? I have PHY_PWR_CTRL disabled and
> I assume there are more steps I can take to disable unneeded function=
s
> on the PMIC but I have not gotten far yet.
One thing I can think of is to verify that the power supplies and
clocks external to the OMAP are actually cut off in off mode. The
power IC scripts patches are needed for this [1].

[1] http://marc.info/?l=3Dlinux-omap&m=3D129907267322294&w=3D2

Please note that the PM-enabled git trees for OMAP are found at
http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=
=3Dsummary
and http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.g=
it;a=3Dsummary.

>
> Thanks for any help!
>
> Marshall

Regards,
Jean

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
