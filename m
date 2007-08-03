From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked
	aspresent on OMAP2430
Date: Fri, 3 Aug 2007 13:47:35 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429018FF8C3@dlee13.ent.ti.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181142.567475486@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708031204130.30569@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0708031204130.30569@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> On Thu, 2 Aug 2007, Woodruff, Richard wrote:
>=20
> > CLOCKOUT2 is in the latest functional spec.  This might be a TRM =
error
> > or the removed the ball for later ES versions.
>=20
> looking at 2430 ES2.1 TRM rev G, I can't find any mention of it - =
maybe
> this TRM is out-of-date?

The current TRM for both 243x and 242x is version Q as of July 07.

So you need h, i, j, k, l, m, n, o, p, and q :).  The documentation just =
keeps getting better.

> > In 2420ES1 there was no clockout2 it was added for ES2 and beyond.
>=20
> hmm, wonder if we should add some clock flags for ES revisions...

Well, the difference between ES1 and ES2 can be noticeable (especially =
for 242x).  But no one has gone to production on an ES1 either.  There =
shouldn't be so many to warrant a flag.  In the past we have tracked =
this to keep the pain down in transition from ES1 to ES2 but as time =
goes on most everyone gets updated.

Regards,
Richard W.
