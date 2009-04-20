From: Remith Ravi <remithmailinglist@gmail.com>
Subject: Re: ehci problem on OMAP35xx
Date: Mon, 20 Apr 2009 19:52:51 +0530
Message-ID: <814dfab70904200722y34a5f70fv7708d6240ae03c27@mail.gmail.com>
References: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:30837 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbZDTOWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 10:22:53 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1352056tim.23
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 07:22:51 -0700 (PDT)
In-Reply-To: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, twebb <taliaferro62@gmail.com>

On Wed, Apr 15, 2009 at 9:34 PM, twebb <taliaferro62@gmail.com> wrote:
> I'm having issues getting USB up and going on HSUSB2/EHCI on
> OMAP35xx-based hardware (very similar to beagle board). =A0We're usin=
g
> an SMSC3317 connected to HSUSB2, and in turn, the 3317 is connected t=
o
> an onboard hub - a SMSC USB2513. =A0When the hub is removed from rese=
t,
> it appears that handshaking/chirping starts to happen between xcvr an=
d
> hub, but ends with the code announcing that it is "unable to enumerat=
e
> USB device on port 2". =A0I'm guessing it's failing because we never =
see
> PED set in the PORTSC_1 reg (and we are seeing PO=3D1 which doesn't m=
ake
> any sense).

Is the driver chirping properly? Is it identifying the speed properly?
I had a similar problem. Please check the D+ and D- line for loading.
I used SMSC3320 which also had similar problems because of
ESD protection thermistors placed in the board.


> I'm running a l-o git-based 2.6.28-omap1 kernel with
> omap3_beagle_defconfig. =A0Beagle board works fine (with patch to
> ehci-omap.c and with CONFIG_USB_EHCI_HCD turned on), but my hardware
> (with virtually same xcvr and and onboard hub) does not.
>
> Kind of new to this low level USB functionality, so a few questions..=
=2E
> 1. =A0Any ideas why we'd see PORTSC_1[PO] =3D 1?
> 2. =A0Any suggestions on debugging basic connectivity between 35xx EH=
CI
> controller and transceiver + hub?
>
> Thanks,
> twebb
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
