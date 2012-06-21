From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Thu, 21 Jun 2012 19:58:15 +0100
Message-ID: <20120621185815.GA2426@n2100.arm.linux.org.uk>
References: <20120427171933.GE28062@n2100.arm.linux.org.uk> <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com> <20120427183116.GF28062@n2100.arm.linux.org.uk> <20120427193129.GA3951@n2100.arm.linux.org.uk> <20120429203525.GA4618@n2100.arm.linux.org.uk> <4F9E3EB5.8030104@ti.com> <20120621125903.GA17984@n2100.arm.linux.org.uk> <20120621131642.GA27383@n2100.arm.linux.org.uk> <20120621132249.GA27635@n2100.arm.linux.org.uk> <CAPo=G1wbwt_wO8HV7+WqTqDcFO6bbjj2eYSNwNVMGyhDM_1vuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60073 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141Ab2FUS6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 14:58:23 -0400
Content-Disposition: inline
In-Reply-To: <CAPo=G1wbwt_wO8HV7+WqTqDcFO6bbjj2eYSNwNVMGyhDM_1vuw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Thu, Jun 21, 2012 at 09:36:12PM +0300, Ujfalusi, Peter wrote:
> Hi Russel,
>=20
> On Thu, Jun 21, 2012 at 4:22 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> Okay, reverting back to v3.4-rc4 works.
> >
> > As does reverting to v3.4, of course. =A0So, it was broken during t=
he last
> > merge window.
>=20
> Strange...
> I had no problem with the SDP4430/Blaze audio with 3.5-rc2 last week.
> Have you restored the mixers with
> alsactl -f blaze.aconf restore
> command?
>=20
> Does aplay (seemingly) plays the file OK or is it times out with an
> error after a while?

It is as I said:

v3.5-rc3:
# alsactl -f blaze.aconf restore
# aplay -f S16_LE -r 48000 -c 2 file.raw
=2E.. plays in about the right time but no audio ...

v3.5-rc3 with the diff from v3.4..v3.5-rc5 for sound/soc/omap totally
 reverted:
# alsactl -f blaze.aconf restore
# aplay -f S16_LE -r 48000 -c 2 file.raw
=2E.. plays perfectly ...

Exactly the same procedure.  Only difference is I've backed out _all_ t=
he
updates to sound/soc/omap.  Clearly something in there is buggered.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
