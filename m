From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are disabled
Date: Thu, 25 Nov 2010 17:47:33 +0100
Message-ID: <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45528 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0KYQrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 11:47:35 -0500
Received: by qyk12 with SMTP id 12so2042229qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 08:47:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

Hi,

On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The console semaphore must be held while the OMAP UART devices are
> disabled, lest a console write cause an ARM abort (and a kernel crash=
)
> when the underlying console device is inaccessible. =A0These crashes
> only occur when the console is on one of the OMAP internal serial
> ports.
This does not fix the issue for me on Beagle (console on ttyO2).

Doing:
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
and waiting 5 seconds hangs the console.

However enabling sleep_while_idle before configuring the UART2 timeout
makes it work ok:
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
  / # echo 1 > /debug/pm_debug/sleep_while_idle
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout

This result is similar to what I tested on a recent l-o master w/o the =
fix.
Am I missing something?

One more remark. With OFF mode enabled I noticed that PER can go OFF
without CORE going OFF, which could trigger the errata i582. I think
this is another latent problem.

/ # cat /debug/pm_debug/count
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1=
-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
per_pwrdm (ON),OFF:3797,RET:2382,INA:0,ON:6180,RET-LOGIC-OFF:0,RET-MEMB=
ANK1-OFF:0
dss_pwrdm (OFF),OFF:1,RET:1,INA:1,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:778,RET:3019,INA:0,ON:3798,RET-LOGIC-OFF:0,RET-MEMB=
ANK1-OFF:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:4367,RET:1806,INA:6,ON:6180,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:4367,RET:1806,INA:6,ON:6180,RET-LOGIC-OFF:0,RET-MEMB=
ANK1-OFF:0
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
=2E..

Any thoughts?
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
