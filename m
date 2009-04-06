From: Russ Dill <russ.dill@gmail.com>
Subject: voltage_off_while_idle confusing in tmlind/linux-omap-2.6/pm.git
Date: Mon, 6 Apr 2009 04:40:13 -0700
Message-ID: <f9d2a5e10904060440n62159ce6kd7827e4f8c231f1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:29180 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbZDFLkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 07:40:15 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2160547rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2009 04:40:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

The following patch:

Author: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>  2008-08-26 02:=
56:02
Committer: Kevin Hilman <khilman@deeprootsystems.com>  2009-03-25 10:11=
:41

    OMAP: PM: sysfs interface for enabling voltage off in idle

    This patch creates a sysfs interface (/sys/power/voltage_off_while_=
idle) to
    set or clear a variable which can be used in determining wether vol=
tage
    regulators should be shut down in idle.

    Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Modifies the PM_VOLTCTRL register of the omap3. It sets AUTO_SLEEP by
default, sets AUTO_OFF when powering off the CORE domain, and sets
SEL_OFF based on the voltage_off_while_idle sysfs file. Several bits
are incomplete.

1.12.5.1.4 PRM_VOLTCTRL (Voltage Source Control Register)
       This register allows control of the power IC. The following are
the register bit fields:
       =E2=80=A2 AUTO_SLEEP: Automatically sends the sleep command when=
 the
voltage domain is in the appropriate
          standby mode
       =E2=80=A2 AUTO_RET: Automatically sends the retention command wh=
en the
voltage domain is in the
          appropriate standby mode
       =E2=80=A2 AUTO_OFF: Automatically sends the off command when the
voltage domain is in the appropriate
          standby mode
       =E2=80=A2 SEL_OFF: Controls whether the off command is sent thro=
ugh the
voltage controller I2C interface or the
          signal sys_off_mode is asserted when entering off mode
       =E2=80=A2 SEL_VMODE: Allows control of the power IC through eith=
er the
voltage controller I2C interface or the
          VMODE interface

The voltage_off_while idle flag thus does not do what it says it does.
It merely selects the action by which the AUTO_OFF functionality
works.

The patch does set AUTO_OFF to true when sleeping if the core domain
is to be shut off, so in that sense it works. However, on my platform
(Beagleboard), the regulators for VDD1 and/or VDD2 do not shut off
with SEL_OFF=3D1 or SEL_OFF=3D0 (further investigation required).

The AUTO_SLEEP flag has been removed by e1c76c42 in order to reduce C
state latency:

Author: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
2009-01-14 09:32:35
Committer: Kevin Hilman <khilman@deeprootsystems.com>  2009-03-25 10:13=
:25

    OMAP3: PM: Don't scale voltage in C1 state

    This patch prevents VDD1 and VDD2 to go to the lowest OPP when ente=
ring C1.
    It improves wakeup latency from 600us to about 50us.

    Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.co=
m>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
