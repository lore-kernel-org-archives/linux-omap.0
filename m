From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Tue, 27 Feb 2007 13:24:38 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274296D3FEE@dlee13.ent.ti.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>	<20070209165157.GB22121@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>	<20070210174121.GA5291@atomide.com>	<20070210190845.GA19642@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D9130274295B9C49@dlee13.ent.ti.com>	<45E47C35.5030707@indt.org.br>
	<3B6D69C3A9EBCA4BA5DA60D9130274296D3F9B@dlee13.ent.ti.com>
	<45E484C4.3020107@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45E484C4.3020107@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > What does not working mean?  No boot, crash on card insertion, card
not
> > taking some command?
>=20
> Card is not being recognized. The clocks are initialized, after that,
> nothing happens when a mmc card is
> inserted/removed. I guess it is ok for H4 once the driver does not
support
> two MMC slots, yet.

As I recall Menelaus IO companion chip really only supports 1 slot.  If
the drivers (menelaus + mmc) are smart then menelaus can multiplexed
between the two slots.

It might be only 1 slot in the H4 port is supported (I know the state
for the open source driver sets, even for internal version I think we
only coded up for 1 of the 2).   Seems like at least a couple bugs exist
in this version (mmc power up for sure, and likely menelaus-h4-port
related)...  Does either of the slots work?

Regards,
Richard W.
