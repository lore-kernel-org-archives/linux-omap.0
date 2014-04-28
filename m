From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Mon, 28 Apr 2014 09:52:30 +0300
Message-ID: <535DFAAE.1010606@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6950961109137922703=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140425153150.GA20807@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6950961109137922703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="R0fkEM4aFfVHFtXemTfENm1CcBGTSsUCI"

--R0fkEM4aFfVHFtXemTfENm1CcBGTSsUCI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/04/14 18:31, Tony Lindgren wrote:

> Chances are any mux register in the syscon area already works with
> pinctrl-single,pins or pinctrl-single,bits option. The ones in the
> padconf area should be already mapped so the driver just has to
> request them.

If using the padconf (say omap4_padconf_global for omap4), doesn't that
mean we need to have platform specific bits in the driver? Isn't that
something we've been trying to remove all the time?

 Tomi



--R0fkEM4aFfVHFtXemTfENm1CcBGTSsUCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXfqxAAoJEPo9qoy8lh71YHYP/0YgWF+CwRkET8PHisPYQ+nA
LLb95F6hBl2yjVTh4yzbNg4GtTANzP6REx/UOmMgiU7B7lQtArgu0zrOdgBYceb9
orWwqcmNqiBCOZCOFUXRLulk0ZfwaV9nbKXK7FAi3WFv5K/AM6sANlVTLQyUKYTZ
LS5oRa3TvYkwentu/2r7cc/jKHtC3G9evLSMHv6bZwb22UL9zTN7MEUhIi9C6Wj6
7CFpJB35Dr3K9661jDPwohKODLQBffVMNBOIXw9H1aK2M2aTzaxcPwCiXUMpheix
KtlzJe6z3xfZObS9+xUXr7i0u9jBY4bImfZMrey46sldYZzr85SqnG42Rlbq4zyV
q3JyhPhDMuQ4lDMxslp/O6u5a7tVZDw/TE1KfpIb+1IjUQxTFXQqRqRGR4TTzjBs
ZOEW+CG1KAHhF/1jjULbp8ooSnCY2GEcPUt8YrA7KBJK4QPcz+F+vKhD6gySSeQ0
n0LwRDTP+PLIjAM121Eq61XxVY4pr1VEExWd4a1u6zP7gzpiiidAxsFQOPeTQJHe
BwFcoyW8e5E8MMjYz6jJKV2EKCkFrsX9DeZmOCCheR9ltMsyTM+ThfFjKM3tz5ph
apO39+3cgVBksN+wsNYPkVdTu1Uu4rhDEzORrIHRkE9YxBS0jk3wpSeUM3HKmOny
FNgrQOyiQqjCmV59tdSW
=7I4W
-----END PGP SIGNATURE-----

--R0fkEM4aFfVHFtXemTfENm1CcBGTSsUCI--


--===============6950961109137922703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6950961109137922703==--
