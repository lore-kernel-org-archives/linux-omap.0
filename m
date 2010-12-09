From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
 2.6.38, part two
Date: Thu, 9 Dec 2010 10:41:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012091038420.13430@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101209161932.4f4aae76.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-73605639-1291916461=:13430"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab0LIRlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:41:04 -0500
In-Reply-To: <20101209161932.4f4aae76.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-73605639-1291916461=:13430
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Jarkko

On Thu, 9 Dec 2010, Jarkko Nikula wrote:

> On Tue, 07 Dec 2010 23:18:28 -0700
> Paul Walmsley <paul@pwsan.com> wrote:
>=20
> > This series is available via git from git://git.pwsan.com/linux-2.6 in
> > the branch 'pwrdm_prcm_b_2.6.38'.  It applies on top of the "OMAP:
> > PRCM/powerdomain/clockdomain patches for 2.6.38, part one" series,
> > sent earlier.
> >=20
> > Kevin and OMAP ASoC-hackers, I'd appreciate review and acks, if
> > appropriate, on the patches that touch code that you maintain.  TI
> > OMAP4 PM people, I would appreciate any testing assistance that you
> > may be able to provide.  Beno=EEt, I've tried to keep the kernel data
> > files and the output of the scripts relatively similar, but we might
> > need to do some tweaking of the scripts or data files to align them
> > in the way that makes the most sense.
> >=20
> Is there some patch missing? Part one compiles but this set does not.

Yes, mach-omap2/cminst44xx.h is missing from the posted series.  It's been=
=20
added to the branch on the git server and posted here:

http://www.spinics.net/lists/arm-kernel/msg106850.html

Will repost the updated series after handling some of the other comments.


- Paul
--155748971-73605639-1291916461=:13430--
