From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/8] ARM: OMAP2+: timer: Introduce OF-friendly
 clocksource/clockevent system timers
Date: Thu, 21 Nov 2013 21:51:28 -0600
Message-ID: <20131122035127.GA1417@saruman.home>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
 <1385085414-9034-6-git-send-email-joelf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8418698339833739701=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385085414-9034-6-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joel Fernandes <joelf@ti.com>
Cc: jgchunter@gmail.com, rnayak@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8418698339833739701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 21, 2013 at 07:56:51PM -0600, Joel Fernandes wrote:

[...]

> New functions for OF-only boot are introduced, and we can soon delete the=
 old
> versions once we migrate all platforms. Currently only AM335x is migrated=
 and

actually, you don't need to initialize .init_timer at all in DT boot.
Just use CLKSOURCE_OF_DECLARE() and pass your omap_generic_timer_init()
as argument (although, I'd call it omap_of_timer_init()).

That will put of_device_id structure on a special section
(__clksource_of_table) and pass your function as a data argument. That
function will be called automatically during init.

--=20
balbi

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSjtS/AAoJEIaOsuA1yqREKcYP/2GYbNpgOpiH/l8sQDIW5DEr
gzgopEW5qGhz6DQx1jPQe7F169WIvvz1mXQ7717OKFiOA0YQifxIcoTmdqXzcKAh
q3+gOrKb2m8t4D/4tHFH6FmjjwQIAzzJbNygMLV58qDWICrWPfQ2vxoJGKhw8OAR
/0hiCOyWk5CMBIyseHiENw3Wnj0dN/eHvcYY0W5Sm6FLT0El1pwRrzKK0MchpYW2
LmPv4FJH2KzkQSPolQp0FYVlKJ2f6IbPhzGusY9GQGOr00QDm2J+cH+WR9R2WMoh
ZD7xjcHSRs7MgRlockUykZ/zqc34F8XNiA3qZSjrrO9KAsw/ttF8tjPD7RCoz8yd
v2WbrFp/Wd2J+6CSoJ8nzAzCseWh/UuvZ4oF1RSHl9XFTIk7Stpwtk3VhxuQisgE
lTyzA4z7Xoq8zTCwVt7CVASJdthUb4mqr9p1xLbqmQS3/n1MeB1wm2VdH5KB8BEq
9vw8jqpT7ie26Vjf+vA328Up7rTkQlifAVwYvWF7w1ZAvDRgDXkqGVuIpHwj1BGc
iQshAE/4KTdtDnLyW5RmOg0pdqkYog3k30S0hK5hlbZHF/YUi0k9IrG2cW60KYqI
bi2Jxwe1op2FODBrFD6n5or1GgJlLB/fGCvPVy/WbHlBBd8EejydkK/+6Qb8QER7
lCHVOuB3Fx17QxQN6+aI
=0c5Q
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--


--===============8418698339833739701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8418698339833739701==--
