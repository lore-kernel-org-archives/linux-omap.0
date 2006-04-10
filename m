From: "Kanagesh R" <kanagesh@india.com>
Subject: Problems compiling with GCC-4.0.0
Date: Mon, 10 Apr 2006 12:52:39 +0800
Message-ID: <20060410045239.55C6143AA1@ws5-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I have been using a toolchain built using crosstools.=20=20
The version of tools is as follows:
GCC-3.4.1
Binutils-2.15
GLIBC-2.3.2

This has been compiling all kernels (2.6.12, 2.6.13,=20
2.6.15) fine without any issues.=20=20

I've now downloaded the ELDK (Ver 4) toolchain from=20
www.denx.de and I've tried to compile 2.6.15-omap1,=20
but without success.  It breaks while compiling file=20
drivers/input/touchscreen/omap/ompa_ts.c  (however,=20
when the same sources are compiled with GCC-3.4.1,=20
it builds fine)

The version of tools in this toolchain is:
GCC-4.0.0
Binutils-2.16.1
GLIBC-2.3.5

I then built a GCC-4.0.0 crosscompiler using crosstools
and I hit the same problem.=20=20

Is anyone else using the ELDK-4.0 toolchain (or crosscompiler
GCC-4.0.0) and has similar problems?=20

warm regards,
Kanagesh


--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
