From: Marshall Crocker <maroc81@gmail.com>
Subject: PM Questions
Date: Wed, 16 Mar 2011 14:31:56 -0500
Message-ID: <AANLkTinoW69jLYpRoGU+bSXr=0x7GFGyJmr4Nj4GSDzL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57393 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab1CPTeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 15:34:18 -0400
Received: by fxm17 with SMTP id 17so2023626fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 12:34:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I have a few questions about PM functionality I would be grateful if
someone could answer.

I'm trying to reduce power on a gumstix overo COM with the latest
2.6.38 pm kernel branch up and running,=A0 I've enabled sleep while idl=
e
and "off" mode along with serial timeouts and I do in fact see a major
drop in power consumption when it hits idle/off mode.

1) Should the "mem" power state reduce power further?=A0 Or does that
simply force the omap into the same states achieved by sleep while
idle and off mode enabled?=A0 I'm not seeing any less power in "mem"
state versus idle/off state.
2)=A0 I saw from earlier emails that DVFS is currently disabled.=A0 Wou=
ld
I see any power additional power savings with DVFS?=A0 Obviously, power
would be reduced if I ran a governor such as on demand so that waking
up from idle doesn't use full speed unless needed.=A0 Are there any
other benefits?=A0 Should I wait for DVFS to be merged back in to PM or
apply the patches that are waiting for approval?
3) Are peripherals such as SPI, I2C, etc disabled when in idle/off
mode?=A0 I'm coming from a microcontroller background where disabling
unused peripherals can save power.=A0 Is that true for the omap?
4) Any additional power saving tips? I have PHY_PWR_CTRL disabled and
I assume there are more steps I can take to disable unneeded functions
on the PMIC but I have not gotten far yet.

Thanks for any help!

Marshall
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
