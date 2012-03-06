From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 4/6] ARM: OMAP3+: PRM: Enable IO wake up
Date: Mon, 5 Mar 2012 21:21:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203052001240.6649@utopia.booyaka.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-991353765-1331003790=:6649"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965036Ab2CFEVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 23:21:47 -0500
In-Reply-To: <1330701475-22576-5-git-send-email-t-kristo@ti.com>
Content-ID: <alpine.DEB.2.00.1203052017230.6649@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, rnayak@ti.com, Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, dnilesh@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-991353765-1331003790=:6649
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1203052017231.6649@utopia.booyaka.com>

added Rajendra, Nilesh, Vishwa, Mohan

Hi

On Fri, 2 Mar 2012, Tero Kristo wrote:

> Enable IO Wake up for OMAP3/4 as part of PRM Init. Currently this has bee=
n
> managed in cpuidle path which is not the right place. Subsequent patch
> will remove IO Daisy chain handling in cpuidle path once daisy chain is
> handled as part of hwmod mux. This patch also moves the OMAP4 IO wakeup
> enable code from the trigger function to init time setup.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Should we keep the I/O wakeups enabled all the time?

Seems like that could result in at least one spurious wake-up event -- and=
=20
thus a PRCM interrupt -- for each I/O pad that has WAKEUPENABLE set. =20
Seems like these interrupts could recur every time the I/O chain is reset. =
=20
And that the I/O chain is now reset in every hwmod idle and enable=20
operation for an IP block that contains dynamic mux data?

Thinking about the problem na=EFvely... maybe you all can think through thi=
s=20
with me:

Consider an IP block 'A' that has a signal (like the UART rx_irrx signal)=
=20
that's mux'ed to a pad with WAKEUPENABLE set.  (Some examples of 'A' might=
=20
include a UART, a GPIO, or a McBSP.) =20

Shouldn't we enable I/O wakeups (by setting EN_IO/GLOBAL_WUEN) only=20
immediately before the powerdomain containing IP block 'A' is going to=20
transition into RETENTION or OFF?

If we do that, then we can avoid needlessly resetting the I/O chain when a=
=20
powerdomain is not going to go into a low-power state.

I haven't measured the time it takes for the I/O chain to be reset. =20
Maybe one of you have.  But that 100 microsecond timeout that was=20
specified in two of the other patches in this series has me a little=20
worried.


- Paul
--155748971-991353765-1331003790=:6649--
