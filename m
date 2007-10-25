From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 14:58:58 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290253055D@dlee13.ent.ti.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
	<31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
	<31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253052A@dlee13.ent.ti.com>
	<31e679430710251242g4e0eb2f5g7d02978d2d79ed70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <31e679430710251242g4e0eb2f5g7d02978d2d79ed70@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> > TI 2430 and 3430 images have necessary code to make all this work =
for
> OTG.  There likely is some work in merging it back into the latest =
omap-
> git.
> >
>=20
> I suppose you mean internal TI linux kernel trees here... Is there any
> plans for releasing this code ?

Yes and yes.  You can get the 2430-MUSB+T2 code from the website today =
against an old kernel.

We have fully working images against 2.6.22 and also a more recent one =
against 2.6.23 (OTG/Host/Client).

As with the bridge code I think any time from today to a month+ current =
code should always be available.

> I'm really interested in seeing this happening, after working on tusb
> i'd like to keep going with omap 2430 and omap3 support...

There is always plenty to do with USB ;) 3430-ES2 is no exception.  In =
addition to the M-USB (internal tusb) there is now a new multi-port EHCI =
controller block.

Regards,
Richard W.
