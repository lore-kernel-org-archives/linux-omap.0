From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: DSS2: HDMI: Add support for audio
Date: Wed, 18 May 2011 23:36:25 -0500
Message-ID: <1305779785.1920.2.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
	 <1305655217.1883.51.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
	 <1305699226.1834.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56912 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015Ab1ESEhv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 00:37:51 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4J4bp9h004511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 23:37:51 -0500
In-Reply-To: <1305699226.1834.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

Hi Tomi,
Le mercredi 18 mai 2011 =C3=A0 01:13 -0500, Valkeinen, Tomi a =C3=A9cri=
t :
> Hi,
>=20
> On Tue, 2011-05-17 at 13:00 -0500, Ricardo Neri wrote:
> > Hi,
> >=20
> > I would like to solicit comments on this set of patches. Now that A=
SoC
> > part of the implementation has been Ack'ed by ASoC maintainers, the=
se
> > patches are needed.
>=20
> I think the patches look ok. However, they don't apply to the current
> DSS2 master branch. Can you rebase to
>=20
> git://gitorious.org/linux-omap-dss2/linux.git master
>=20
> and send me patches or a git url from which I can pull.

I have rebased the patches. Here is the information for you to pull the
changes:

The following changes since commit
9138edf3cb53ecf5cfab2323d9b319bdb0a2ae25:
  Archit Taneja (1):
        OMAP4: 4430SDP: Add Panel Taal device struct in 4430sdp board
file

are available in the git repository at:

  git://gitorious.org/omap-audio/linux-audio.git
ricardon/topic/hdmi-audio-for-tomi

Ricardo Neri (5):
      OMAP4: DSS2: Create a DSS features structure for OMAP4430 ES1.0
      OMAP4: DSS2: HDMI: Add DSS feature for CTS calculation
      OMAP4: DSS2: HDMI: Add enums and structures for audio
      OMAP4: DSS2: HDMI: Add functionality for audio configuration
      OMAP4: DSS2: HDMI: Implement ASoC Codec driver for HDMI audio

 drivers/video/omap2/dss/dss_features.c |   29 ++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/hdmi.c         |  432
++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi.h         |  220 ++++++++++++++++-
 4 files changed, 678 insertions(+), 4 deletions(-)


Thanks!

Ricardo
>=20
>  Tomi
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
