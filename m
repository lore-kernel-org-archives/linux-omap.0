From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev: Remove deprecated create_singlethread_workqueue
Date: Wed, 10 Aug 2016 13:44:18 +0300
Message-ID: <52673b62-66b6-694c-134a-48a64d8022ad@ti.com>
References: <20160702083923.GA27352@Karyakshetra>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="80JSbD7N7EvjlFDOjbNrB3rL3xNUa0qtm"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160702083923.GA27352@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tejun Heo <tj@kernel.org>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--80JSbD7N7EvjlFDOjbNrB3rL3xNUa0qtm
Content-Type: multipart/mixed; boundary="LW44xtQgXIjfKGWLjhTJidH3Sbegkb1Pq"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tejun Heo <tj@kernel.org>, linux-fbdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <52673b62-66b6-694c-134a-48a64d8022ad@ti.com>
Subject: Re: [PATCH] fbdev: Remove deprecated create_singlethread_workqueue
References: <20160702083923.GA27352@Karyakshetra>
In-Reply-To: <20160702083923.GA27352@Karyakshetra>

--LW44xtQgXIjfKGWLjhTJidH3Sbegkb1Pq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/07/16 11:39, Bhaktipriya Shridhar wrote:
> The workqueue "esd_wq" has only a single workitem(&md->esd_work)
> and hence doesn't require ordering. Also, it is not being used on a
> memory reclaim path. Hence, the singlethreaded workqueue has been
> replaced with the use of system_wq.
>=20
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreade=
d
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueu=
e
> created with create_singlethread_workqueue(), system_wq allows multiple=

> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
>=20
> mipid_esd_stop_check () calls cancel_delayed_work() in mipid_cleanup()
> to ensure that there are no pending tasks while disconnecting the drive=
r.
>=20
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> ---
>  drivers/video/fbdev/omap/lcd_mipid.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Thanks, queued for v4.9.

 Tomi


--LW44xtQgXIjfKGWLjhTJidH3Sbegkb1Pq--

--80JSbD7N7EvjlFDOjbNrB3rL3xNUa0qtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwWCAAoJEPo9qoy8lh71bt4P/1t+6MsXCfFzotkDxhX5deHb
w72reQCsxsQ7N9X7TOsoYettEqEPo11HKb3NY28gv9R5ezJMvobPO/ShKnOJJbfX
FKZdbovWywDhCECy5oh43ltLe61jHEOk1g1j6NTTk5iu47YKY8Z9QEzP6z88cZBw
oS43+ZVTwmU/IyOeLFe2F2TLZ6lOltpXA0dvMmTtHpSTJnhFU2EEJ0S0g6GlVEKW
zhvxeKhPf2+Jkd/9FzdF5IPZ0V+TECRkYJKZyZ6J5X9M++xIQPRJOOrMz4mu13bf
Kt+JRyCwxNH9Vyz9TpxdL4LiOME6Qr2jPU78fE5zxE8/bhfO0S+tZbVmSQ6aSvzn
/ewtB46FfRiVoiXaNAKvtZV2bFenC4PTE/6Fy3h99/o65Pt0VrfF0i9BIO7f5/Z0
7uXyU9tSmIj2EiMzS/kjBHccAZTzsR3Kp1NOJyI+LUNcm3sxXIk6NQi+x7WP53t6
2X6UxT/PAXXjfyxSeuIMtkwgx20etZXS3+CmCF86RbRaoVPM/DOSGGHQKHvkRrvF
T8NFmGIHrz9DBnafA/98o6kxnD7RGodCpL5za6qmGuuTO1Mou59+tFENCt8/tPID
KiOvhpT6U7wjjvcez4ojHSRSw6a/Xk8tBTTPPdBbMNkBWITmz+Hnf1LlpfCFGBsA
VHyaWQY3lAn+2sJuQb8V
=IkN8
-----END PGP SIGNATURE-----

--80JSbD7N7EvjlFDOjbNrB3rL3xNUa0qtm--
