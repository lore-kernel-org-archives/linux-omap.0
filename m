From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][PATCH] ARM: OMAP: Always enable the R/W access to all
	initiators in sram
Date: Mon, 26 Nov 2007 11:02:23 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429028C56E5@dlee13.ent.ti.com>
References: <20071126020738.GA32424@party>
	<Pine.LNX.4.64.0711260348500.2694@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0711260348500.2694@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> On Mon, 26 Nov 2007, Kyungmin Park wrote:
>=20
> > With recent runtime constatns patches, we can't boot the board if =
the
> sram is locked.
> > I'm not sure it's the proper patch enables R/W access to all =
omap242x.
> > But without this patch, it gives the following messages and abort on
> linefecth
>=20
> I am puzzled.
>=20
> You have definitely found a bug.  It seems that TI, for some unknown
> reason, moved some SCM registers, including CONTROL_STATUS, for 34xx,
> breaking forward compatibility.  And as you point out, the offset for
> CONTROL_STATUS in the recent patch is not right for 242x.  (It's the
> 34xx offset.)

24xx is not 34xx.  Among others pieces around PRCM, Security, =
package-configuration will be different.  Trying to hide omap3 under =
omap2 just makes some of these things harder to rediscover as the git =
tree evolves. =20

To make OFF mode work for targeted use cases, and match with trust zone =
security some register groups have been split or moved.

> I would think this would prevent 242x from booting.  Indeed, you =
report
> that your setup doesn't boot.  But when I boot current git on N800 =
here,
> which is 2420-based, it boots fine.  Puzzling evidence.

** Probably your boot loader does it and his doesn't.  And/Or there are =
a couple other bugs around Type (emu,hs,gp,tst) and ES version.

There are real behavioral differences between GP and EMU devices and in =
some cases also differences between ES versions of the chip as to what =
mask ROM code does for you.  Firewall settings are one major part.  Boot =
testing on one GP device of one ES version is really not enough.

I think this kind of thing also was evident in the UART clock setting.  =
The u-boot we use is only turning on what is necessary where it seems =
the nokia one is configuring a lot more. =20

* The Nokia boot loader should do as little as possible in clock and =
security regards else there is a danger the kernel will need a lot of =
rework when you try and use these features more optimally.

Regards,
Richard W.
