From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: HWMOD: Handle opt clocks using clk_add_alias
Date: Tue, 21 Sep 2010 18:31:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211830200.4677@utopia.booyaka.com>
References: <1282578269-8835-1-git-send-email-p-basak2@ti.com> <4C72D6AC.3060509@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E83DC40B@dbde02.ent.ti.com> <4C74FEEE.2090300@ti.com> <4C7526C6.7090207@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1933377888-1285115490=:4677"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45541 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0IVAbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:31:31 -0400
In-Reply-To: <4C7526C6.7090207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1933377888-1285115490=:4677
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE


For the archives:

On Wed, 25 Aug 2010, Cousson, Benoit wrote:

> Re-sent to loml, the original email was sent to lkml...
>=20
> On 8/25/2010 1:30 PM, Cousson, Benoit wrote:
> > On 8/25/2010 12:45 PM, Basak, Partha wrote:
> > >=20
> > > > From: Cousson, Benoit
> > > > Sent: Tuesday, August 24, 2010 1:45 AM
> > > >=20
> > > > Hi Partha,
> > > >=20
> > > > On 8/23/2010 5:44 PM, Basak, Partha wrote:
> > > > > From: Basak, Partha<p-basak2@ti.com>
> > > > >=20
> > > > > For every optional clock present per hwmod per omap-device, this
> > > > function
> > > > > adds an entry in the clocks list of the form<dev-id=3Ddev_name, c=
on-
> > > > id=3Drole>,
> > > > > if an entry is already present in the list of the form<dev-id=3DN=
ULL,
> > > > > con-
> > > > id=3Drole>.

A modified version of this patch was queued for merging for 2.6.37;=20
details here:

http://www.spinics.net/lists/linux-omap/msg36805.html

Thanks Beno=EEt for reposting the original.


- Paul
--155748971-1933377888-1285115490=:4677--
