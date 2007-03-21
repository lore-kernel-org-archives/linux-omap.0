From: "Jalori, Mohit" <mjalori@ti.com>
Subject: RE: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Wed, 21 Mar 2007 14:15:54 -0500
Message-ID: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
References: <20070321004030.424076000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070321004030.424076000@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Kevin Hilman
> Sent: Tuesday, March 20, 2007 7:41 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
>=20
> Adds platform device for use of existing OMAP2 driver.  Also, the
> following changes are made to the existing driver:
>=20
> - add option for not using DMA (by passing dma_channel =3D -1)
> - removes obsoleted pt_regs arg from interrupt handler
>=20
> RFC: Notice the change to onenand_base.c which comments out the last
>      OOB chunk.  Without this, it would not work.  Previous drivers
>      for this board such as the 2.6.10-based MV kernel have this
>      same change.  Anyone know what is going on here?
>=20

We got this change from MV in the patch he sent to fix an issue we were
seeing with mounting an empty jffs2 partition. Here are the comments
that came in with it

" The oobfree list in the MTD OneNAND driver is of length 8.  This
exceeds the maximum length of 7, because the eighth entry must be used
as a null terminator.  The absence of a terminator causes a variety of
problems in various places (especially JFFS2 and YAFFS2) where the
oobfree list is scanned.  The fix is to do without the eighth entry.=20

This fix is only of local interest because the handling of oobinfo has
been completely redesigned as of 2.6.17-rc6. "


>From the last line we should not need this for later kernel versions.

Regards
Mohit
