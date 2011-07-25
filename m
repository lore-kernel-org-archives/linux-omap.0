From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP3: Beagle: NAND: Specifying partition offsets
 directly.
Date: Mon, 25 Jul 2011 16:19:53 +0300
Message-ID: <20110725131953.GZ18062@legolas.emea.dhcp.ti.com>
References: <1311599243-875-1-git-send-email-hrishikesh.b@ti.com>
 <20110725131406.GY18062@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOmQO3H5Qmmwdmk8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33343 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139Ab1GYNT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 09:19:56 -0400
Received: by mail-ey0-f177.google.com with SMTP id 6so3599281eyh.8
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 06:19:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110725131406.GY18062@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org


--hOmQO3H5Qmmwdmk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Mon, Jul 25, 2011 at 04:14:06PM +0300, Felipe Balbi wrote:
> On Mon, Jul 25, 2011 at 06:37:23PM +0530, Hrishikesh Bhandiwad wrote:
> > In the nand partition table specifying the offset addresses
> > directly instead of using the macro MTDPART_OFS_APPEND to gain
> > runtime efficiency while nand initialization.
> > MTDPART_OFS_APPEND has the value (-1) ,if assigned to offset,
> > a runtime calculation of actual offset happens each time nand is
> > initialized [ Refer: drivers/mtd/mtdpart.c: allocate_partition()].
> > To avoid this , specify actual offset.
> >=20
> > Signed-off-by: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
>=20
> did you measure any significant gains when doing this ? Also, why only
> beagle ? why not all boards already ? Measurment data of how long it
> takes for the runtime calculation of the offset to complete would be
> nice to see.

I was just looking at the code and the offset calculation will always be
done regardless of you using the direct offset or the MTDPART_OFS_APEND.
The only thing you avoid by setting it directly is a branch.

See here:

648 int add_mtd_partitions(struct mtd_info *master,
649                        const struct mtd_partition *parts,
650                        int nbparts)
651 {
652         struct mtd_part *slave;
653         uint64_t cur_offset =3D 0;
654         int i;
655=20
656         printk(KERN_NOTICE "Creating %d MTD partitions on \"%s\":\n", n=
bparts, master->name);
657=20
658         for (i =3D 0; i < nbparts; i++) {
659                 slave =3D allocate_partition(master, parts + i, i, cur_=
offset);
660                 if (IS_ERR(slave))
661                         return PTR_ERR(slave);
662=20
663                 mutex_lock(&mtd_partitions_mutex);
664                 list_add(&slave->list, &mtd_partitions);
665                 mutex_unlock(&mtd_partitions_mutex);
666=20
667                 add_mtd_device(&slave->mtd);
668=20
669                 cur_offset =3D slave->offset + slave->mtd.size;
670         }
671=20
672         return 0;
673 }

regardless of you passing MTDPART_OFS_APEND or direct slave->offset,
cur_ofsset will be calculated, and that thing looks really cheap to
execute to me. The only thing you're avoid is:

467         slave->offset =3D part->offset;
468=20
469         if (slave->offset =3D=3D MTDPART_OFS_APPEND)
470                 slave->offset =3D cur_offset;

the if at line 469. Am I missing something ??

--=20
balbi

--hOmQO3H5Qmmwdmk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLW15AAoJEAv8Txj19kN1m6cH/3z3vDNbpIxSlwemjOVOgcGe
f0mystAM/k3a7eOtPRyjCKy97R35PcdmjxqC2LEAytuf09OMeEnKLg3CKf6GlRMF
8QfNcuW4ygYiyg/2EgLYZIX7Q9tpUd+tOjDpJjNcwmL2PUs1+/Na4FdbFQahq6rm
lit9WL/Gvhhd3WT96zBTaSAVpwlgT+nydqHJ2o85HqkInXbYnsPBsR/rTuK60gwv
mja4Rw3ZSeMomCVBrVPD44zNp9OqdOooJneFDmgCNd9rbuj6pDWkZvUjjGvMQAeN
L3OqV+JyXz2Y1RYCzm2oJe9rqVt/39+bPNv1MThGDpSCAoLtAJvlDKyCZX09B4A=
=BGYe
-----END PGP SIGNATURE-----

--hOmQO3H5Qmmwdmk8--
