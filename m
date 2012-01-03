From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Tue, 3 Jan 2012 10:24:40 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D1214304BAD3@DBDE01.ent.ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
 <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
 <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54306 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2ACKYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 05:24:50 -0500
In-Reply-To: <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Govindraj,

On Mon, Jan 02, 2012 at 16:00:37, Govindraj wrote:
>=20
> currently runtime pm is available from omap-serial device and not fro=
m tty_dev.
> Setting tty_dev wakeup is to use irq_wakeup from suspend available
> from serail_core layer which I think we are not using for omap-uart
> and we use pad wakeup from suspend path.
>=20
> Also omap-uart.x/power/wakeup is used to gate uart clocks using runti=
me
> PM api's in omap-serial driver.
>=20

Thanks for clarifying. On AM335x, one of the UARTs is in a wakeup domai=
n
and swakeup from this is used to come out of suspend.

I have basic suspend-resume working on it. Strangely this works irrespe=
ctive
of the value of tty_dev wakeup entry. Do you know if this is expected o=
n OMAP?

The other issue concerning runtime PM is that as soon as I set a non-ze=
ro to
the autosuspend_delay_ms I get some garbage characters and eventually t=
he
console stops responding.

[root@arago /]# cat .../omap_uart.0/power/autosuspend_delay_ms
-1
[root@arago /]# echo 3000 > =D6KW=EB=E9=AB+=D7=E9=AB+wU.=C9=D1=B9,z,=BD=
=DD.=C9=BDosuspend_delay=D5=A3=BD=CD=D5=CD...
[root@arago /]#	<- No response after some time

The comment in the code mentions delay is receiving characters if runti=
me PM
is enabled. Any idea what's going wrong at my end?

Regards,
Vaibhav B.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
