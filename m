From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] [TWL4030 MADC] Fix ADC[3:6] readings
Date: Fri, 17 Jul 2015 11:00:39 +0200
Message-ID: <20150717090039.GC9331@earth>
References: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com>
 <1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6116480542830181876=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam YH Lee <adam.yh.lee@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============6116480542830181876==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

To get a chance of this patch being considered for inclusion, you
should send this to the maintainers of the phy and iio framework.
There is a high chance, that none of them will see your mail.

On Thu, Jul 16, 2015 at 03:20:27PM -0700, Adam YH Lee wrote:
> MADC[3:6] reads incorrect values without these two following changes:

uhm MADC[3:6] are externally available analog inputs. Your
change will result in them being tied to the USB module.

> - enable the 3v1 bias regulator for ADC[3:6]

The regulator is not required for correct MADC functionality, but
for correct USB measureing. The regulator should not be requested
by the madc module, but by the usb module, which is connected to
the madc.

> - configure ADC[3:6] lines as input, not as USB

I don't think that should be done for all boards.

> [...]

-- Sebastian

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVqMQ0AAoJENju1/PIO/qarvMP/i48T6Mls38GKeYbQ25I87Sb
KX2IP4oicg4vdlG4wACsIBzK9JsFCqL7g84p9o4sdqNXfZ+yBpPTo4LxCRsSo/bo
ujVmK9fMtSNTurFojQ1HnhBmKiSmTDB/K1PACLcPEa4b8Cxlfidyi5XGdxdSqrhE
t0XGuslPJCU7fKV4pEugmJ/pbq7SvU8agDetfP9CgKqHcNQ4dNyP14OQ2tfxIiha
JSbOF6lnLtYbntHJmpuN9/pfgOvGdaXam/n1H6ZYz/jyXWArKOPKUrVXKf+h4iWh
QF+GoVWKSEIdyRQfTOapcML7h0QFCuDRwiyTKshHf5uGhAs2kOX/+1ipGHajRjPm
5cA3yFwfdpBmGapYCuEreYl783T7ApyLK/VrSls7H4LF9SQ3Iotxs/xKVFIzWBW5
lV067xlJGqjrLRDdvQtHEXDALvECxauzFvnBOGSi7LfZWL4Y0JvnQjDGDqltsEV/
0PquSl3BdCT8UC1sF0t/2IN9tfHe+HuEJSBUkDGgoT+lGw6s5nKWPjXcEiBzKBSF
+e3RwptuRn7mZtvW72TJgWlj3nwYRTy0itudpnHVqngUJzOoTa0NaeIpNrmV93wT
VoWRpxgspRkE2WMzZkWdEDdtdzz1VL87kGAnZLKp6CaHeFHa+IoJlDzHAxYCzDKl
cZtllN3gXbmU1lllscTW
=9YcU
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--


--===============6116480542830181876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6116480542830181876==--
