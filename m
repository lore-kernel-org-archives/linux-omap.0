From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked
	aspresent on OMAP2430
Date: Sat, 4 Aug 2007 17:02:01 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429018FFAB9@dlee13.ent.ti.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181142.567475486@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708031204130.30569@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF8C3@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708040951470.2982@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0708040951470.2982@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > The current TRM for both 243x and 242x is version Q as of July 07.
>=20
> That would explain it.  I will pick up the more recent revisions.  In
the
> meantime, I will fix the patch to preserve sys_clkout2 for 2430, and
also
> to fix the register bits to indicate that they are not 2420-only.

You might just hold off.  I didn't see it in rev Q either.  It was added
into the basic functional spec. The F-spec's are the original document
from designers, started a couple years before TRMs and are built up
along with the chips.  Later, TRMs are spun off.

> > So you need h, i, j, k, l, m, n, o, p, and q :).  The documentation
just
> keeps getting better.
>=20
> Does TI publish revision histories?  Might be easier than diff'ing 11
> 3500-page PDFs :-)

Yes they do for OMAP2/3.  I tend to keep 3 back.  I don't have my main
computer handy otherwise I'll send you a document number.

Regards,
Richard W.
