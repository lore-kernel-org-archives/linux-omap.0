From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: softreset fixes with opt clocks
Date: Tue, 21 Sep 2010 11:05:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211102250.29015@utopia.booyaka.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-572596629-1285088706=:29015"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37273 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0IURFp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 13:05:45 -0400
In-Reply-To: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Content-ID: <alpine.DEB.2.00.1009211105100.29015@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, p-basak2@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-572596629-1285088706=:29015
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1009211105101.29015@utopia.booyaka.com>

Hi Beno=EEt,

On Tue, 21 Sep 2010, Benoit Cousson wrote:

> Here are some fixes for the softreset issues that were highlighted
> on some IPs like GPIO or DSS.
>=20
> For the moment they are still based on your previous series:
> git://git.pwsan.com/linux-2.6 hwmod_hardreset_dev
>=20
> If you are OK with these, I'll rebase that on top of your latest submissi=
on to l-o / linux-arm-kernel.

Just took a quick look at them; they both look fine to me.  I do have one=
=20
minor comment on the optional clock patch; I will post it as a reply to=20
that message.

That hwmod_hardreset_dev branch is almost identical to the hwmod_2.6.37=20
branch.  Maybe I should just add your patches to the hwmod_2.6.37 branch,=
=20
along with Rajendra's ENAWAKEUP patch, and post those three to lakml, if=20
you are okay with that?


- Paul
--155748971-572596629-1285088706=:29015--
