From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Mon, 16 Jul 2012 12:38:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1514760656-1342463907=:28834"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35303 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab2GPSi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 14:38:27 -0400
In-Reply-To: <50045D17.9050704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1514760656-1342463907=:28834
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jon,

On Mon, 16 Jul 2012, Jon Hunter wrote:

> Yes I see that makes sense. However, patch #7 has already changed the
> mapping of the flags. I had intended that patch #7 and #8 would be
> applied together. However, I could see that patch #7 can be taken just
> to eliminate using the SW_SLEEP state. So basically, what I am saying is
> does patch #7 have any value without #8?

Certainly not as much value as it had before.  But my understanding, which=
=20
is possibly incorrect, matches what you wrote in patch #7's description:

"For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is=20
equivalent to SW_WKUP. The only difference between HW_AUTO and SW_SLEEP=20
for OMAP4 devices is that the PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt=20
status is set in case of SW_SLEEP transition, and not set in case of=20
HW_AUTO transition."

We don't use that PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt bit.  So if=20
SW_SLEEP and HW_AUTO really have identical meanings otherwise, then I=20
suppose we might as well use the one that does what we need with no=20
extraneous side-effects?  My recollection from a conversation with Beno=EEt=
=20
a few months ago was that this was his view as well.

> That's fine with me. We can always workaround such issues by adding flags=
=2E
>=20
> I can give this a try this week and let you know how it goes.

Okay, great.  No rush on my account.


- Paul
--155748971-1514760656-1342463907=:28834--
