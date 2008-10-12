From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Sun, 12 Oct 2008 22:15:33 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870239624AC3@dbde02.ent.ti.com>
References: <200810030857.37888.david-b@pacbell.net>
 <200810061626.33616.david-b@pacbell.net>
 <5e088bd90810112133ob4f0fa6v5bfe37aece35c98a@mail.gmail.com>
 <200810112343.02304.david-b@pacbell.net>
 <13B9B4C6EF24D648824FF11BE89671620365BC66F5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbYJLQpu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Oct 2008 12:45:50 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620365BC66F5@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, David Brownell <david-b@pacbell.net>, Steve Sakoman <sakoman@gmail.com>
Cc: Anand Gadiyar <gadiyar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.k=
ernel.org] On Behalf Of
>Woodruff, Richard
>Sent: Sunday, October 12, 2008 8:22 AM
>To: David Brownell; Steve Sakoman
>Cc: Anand Gadiyar; linux-omap@vger.kernel.org
>Subject: RE: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
>
>
>> owner@vger.kernel.org] On Behalf Of David Brownell
>
>> > Turns out it is this one in omap_start_ehc:
>> >
>> > =A0=A0=A0=A0=A0=A0=A0=A0/* Wait for TLL to be Active */
>> > =A0=A0=A0=A0=A0=A0=A0=A0while ((cm_read_mod_reg(CORE_MOD, OMAP2430=
_CM_IDLEST3) &
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << OMAP3430ES2_=
ST_USBTLL_SHIFT)));
>>
>> Fishy ... TLL =3D=3D TransceiverLess Link, which is used with
>> on-board links that don't need to be morphed to use signals
>> that go over cables as defined in the USB spec.  I would
>> think you'd want ULPI.
>
>TLL block does get used for some cases for non-tll (phy) mode use. =20

In particular, clocking mode used for EHCI on omap34xx is input clockin=
g mode.
This means OMAP feeds the 60Mhz clock and TLL module is used to generat=
e the 60Mhz clock.
So irrespective of TLL or ULPI-PHY mode, TLL block has to be kept up.




> Recently there was some low=20
>fixes for non-tll mode in which tll block handling was important.  Thi=
s was specifically in ohci
>configuration.
>
>Anand (in copy) did make some fix which changed ordering of clock enab=
les which were necessary to get
>usb bus suspend/resume working.  With the other ordering you would get=
 an abort when accessing that
>blocks registers.
>
>Regards,
>Richard W.
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
