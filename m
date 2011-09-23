From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCHv9 00/18] omap PRCM chain handler
Date: Fri, 23 Sep 2011 18:23:00 -0400
Message-ID: <35343.1316816580@turing-police.cc.vt.edu>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2017307380=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: Your message of "Fri, 23 Sep 2011 15:46:08 +0300."
	<1316781986-30642-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2017307380==
Content-Type: multipart/signed; boundary="==_Exmh_1316816580_33036P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1316816580_33036P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Sep 2011 15:46:08 +0300, Tero Kristo said:
> Following set contains the version 9 of this work. This patch set contains
> a number of patches tagged as 'TEMP', they are only meant for testing
> purposes and to provide proof of concept. Most of the 'TEMP' patches are
> related to UART runtime handling and they will be replaced by work done
> by Govindraj Raja.

What do we do with these TEMP patches if the UART patches don't make the same
merge window, or have other issues?  I'm always leery of "will be replaced"
code, because I've seen too many times when it *didn't* get replaced.

(I really don't care what the 'Plan B' is, as long as we have one...)



--==_Exmh_1316816580_33036P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOfQbEcC3lWbTT17ARAoJHAKDKTuOc5fuoHVqy9MaQZ5Sfgju2CgCcC6VP
esd5WI1469tFcgwhYBmz+50=
=zTeo
-----END PGP SIGNATURE-----

--==_Exmh_1316816580_33036P--



--===============2017307380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2017307380==--
