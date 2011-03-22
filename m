From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/7] OMAP2+: powerdomain: add voltage domain lookup during
 register
Date: Tue, 22 Mar 2011 16:08:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103221502180.11798@utopia.booyaka.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-5-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1103221313460.11798@utopia.booyaka.com> <4D890D9E.804@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1451859189-1300831700=:11798"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58605 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab1CVWIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 18:08:21 -0400
In-Reply-To: <4D890D9E.804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1451859189-1300831700=:11798
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Tue, 22 Mar 2011, Cousson, Benoit wrote:

> On the other hand not every clock belong to a clockdomain, that's why we=
=20
> have clock without clockdomain on OMAP. A clockdomain is a just group of=
=20
> IPs that share the same interface clock.

PRCM clockdomains also include functional clocks.  See for example the=20
OMAP4 Public TRM Rev. O Section 3.1.1.1.3 "Clock Domain" ('The clockdomain=
=20
of CM_B is composed of two clocks: a functional clock (FCLK2) and an=20
interface clock (ICLK1)', and also later, 'The PRCM module lets software=20
check the status of the clock domain functional clocks').=20

Both the TRM and the OMAP4 functional specification clearly link PRCM=20
clockdomain idle management to the state of the clockdomain's functional=20
clocks.  See for example OMAP4 Public TRM Rev. O Table 3-11 "Clock Domain=
=20
Clock States" ('INACTIVE: ... Every optional functional clock in the clock=
=20
domain is gated.')

Beyond the PRCM, the Linux-OMAP clockdomain code is not only concerned=20
with PRCM-controllable clockdomains.  It is intended to be a generically=20
useful way to connect clocks to the powerdomain and voltagedomain that the=
=20
clock exists in, even if there are no explicit PRCM registers associated=20
with the clockdomain.  These "powerdomains" and "voltagedomains" also may=
=20
not be directly PRCM controllable.

Every clock that is in the Linux-OMAP clock tree should have a clockdomain=
=20
associated with it.


- Paul
--155748971-1451859189-1300831700=:11798--
