From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Git tree updated
Date: Tue, 8 May 2007 12:45:07 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429F12539@dlee13.ent.ti.com>
References: <20070508031945.GH31968@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070508031945.GH31968@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I noticed that MMC doesn't compile either.

The include/linux/mmc/card.h structure mmc_card changed removing the
'node' element.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Tony Lindgren
> Sent: Monday, May 07, 2007 10:20 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Git tree updated
>=20
> Hi all,
>=20
> I've updated our git tree to be in sync with mainline tree as Russell
> has merged some of our pending patches.
>=20
> Looks like 24xx does not currently boot, it seems to hang at
> devicemaps_init(). I've verified that at least 16xx boots.
>=20
> I'll have to continue debugging the 24xx devicemaps_init issue
tomorrow,
> if somebody gets it working before that, please post the patch :)
>=20
> Regards,
>=20
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
