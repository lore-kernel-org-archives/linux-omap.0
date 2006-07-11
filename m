From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Build error with latest GIT tree
Date: Tue, 11 Jul 2006 11:11:34 -0500
Message-ID: <C51F43ABFC95844490F0529B60753BF4055F32C0@dlee02.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I did a diff between the clock.h file in the include/asm/arch/ directory
and found the following differences between v2.6.17 and v2.6.17-rc6
(which I belive is the latest);

--- include/asm/arch/clock.h    2006-07-11 10:45:46.000000000 -0500
+++ ../linux-omap-2.6.git/include/asm/arch/clock.h      2006-07-10
16:34:40.000000000 -0500
@@ -48,8 +48,6 @@
 };

 extern unsigned int mpurate;
-extern struct list_head clocks;
-extern spinlock_t clockfw_lock;

I believe the removal of "clocks" variable is why the compiler is
complaining below. Let me know if you have any thoughts.

Cheers,
Jon


=20
> Is anyone seeing the following build error with the latest GIT tree?
> Seemed similar to the following issue, but the exact error looks
> different:
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-Ju
> ne/007473.
> html
>=20
>=20
> CC      arch/arm/mach-omap1/clock.o
> arch/arm/mach-omap1/clock.c: In function `omap1_late_clk_reset':
> arch/arm/mach-omap1/clock.c:609: error: `clocks' undeclared=20
> (first use in this function)
> arch/arm/mach-omap1/clock.c:609: error: (Each undeclared=20
> identifier is reported only once
> arch/arm/mach-omap1/clock.c:609: error: for each function it appears
> in.)
> make[1]: *** [arch/arm/mach-omap1/clock.o] Error 1
> make: *** [arch/arm/mach-omap1] Error 2
>=20
> Cheers,
> Jon
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
