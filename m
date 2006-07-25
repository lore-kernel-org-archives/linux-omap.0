From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: CCS and u-boot
Date: Tue, 25 Jul 2006 12:11:17 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506C5D323@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

U-boot has the ability to execute external modules built within the
u-boot build system.  Much of u-boot's build process is tied to GCC so
it would take a bit more work to extend it so it could build using CCS.
You would need an ABI translation and some amount of a loader to make
that work.

It would much easier to use GCC and build u-boot modules.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Ram
> Sent: Tuesday, July 25, 2006 7:44 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: CCS and u-boot
>=20
> Hi,
>    u-boot can launch standalone binaries (built in a specific  format
> that is understood by u-boot)
>=20
>     Is it possible for u-boot to call a XXX.out file generated out of
> CCS (Code composer studio) ?.
>=20
> If so, should we do anything special in order to make it work? (say
> something we need to specify while linking and so on).
>=20
>=20
> Regards,
> sriram
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
