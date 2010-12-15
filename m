From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
Date: Tue, 14 Dec 2010 18:15:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141813180.15971@utopia.booyaka.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain> <20101214063447.21555.64470.stgit@twilight.localdomain> <4D07782E.5050000@ti.com> <alpine.DEB.2.00.1012141105570.15971@utopia.booyaka.com> <4D07D0A5.9040703@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-875351345-1292375659=:15971"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53489 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760433Ab0LOBPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 20:15:41 -0500
In-Reply-To: <4D07D0A5.9040703@ti.com>
Content-ID: <alpine.DEB.2.00.1012141814360.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-875351345-1292375659=:15971
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1012141814361.15971@utopia.booyaka.com>

Salut Beno=EEt

On Tue, 14 Dec 2010, Cousson, Benoit wrote:

> Well, I sent this series before you sent your prcm one, so at the time th=
e
> dependency didn't exist ;-)

No worries, it was just meant to be a general suggestion, not a specific=20
one to this case.

> > As far as the empty scrm44xx.h goes, I will probably go back and rebuil=
d
> > that branch with your patch that creates SCRM from my patch set inserte=
d
> > earlier, so I can drop the part of my patch that creates the empty file=
=2E

I went ahead and moved the SCRM patch earlier in the branch sets.  I did=20
make one change in it - I'll reply to it with the update details.

The current integration tag that contains the revised patch is=20
'integration-2.6.38-20101214-010' available from=20
git://git.pwsan.com/linux-integration


- Paul
--155748971-875351345-1292375659=:15971--
