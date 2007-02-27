From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Tue, 27 Feb 2007 12:50:31 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274296D3F9B@dlee13.ent.ti.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>	<20070209165157.GB22121@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>	<20070210174121.GA5291@atomide.com>	<20070210190845.GA19642@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274295B9C49@dlee13.ent.ti.com>
	<45E47C35.5030707@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45E47C35.5030707@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Hi Richard,
>=20
> Which board you used to test theses patches?

I didn't fully test MMC.  I did make sure it fixed the boot lock up.

My board is a 'HRP' version using the latest ES rev of the 2420.

> As we've (me and Briglia) mentioned, the mmc it's not working on my H4
> board. I'm still investigating to find out the problem.

What does not working mean?  No boot, crash on card insertion, card not
taking some command?

Did you try with the simple 1 line patch I submitted also?

Regards,
Richard W.
