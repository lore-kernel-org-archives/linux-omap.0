From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: Build error with latest GIT tree
Date: Tue, 11 Jul 2006 09:57:53 -0500
Message-ID: <C51F43ABFC95844490F0529B60753BF4055F31AB@dlee02.ent.ti.com>
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

Is anyone seeing the following build error with the latest GIT tree?
Seemed similar to the following issue, but the exact error looks
different:
http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007473.
html


CC      arch/arm/mach-omap1/clock.o
arch/arm/mach-omap1/clock.c: In function `omap1_late_clk_reset':
arch/arm/mach-omap1/clock.c:609: error: `clocks' undeclared (first use
in this function)
arch/arm/mach-omap1/clock.c:609: error: (Each undeclared identifier is
reported only once
arch/arm/mach-omap1/clock.c:609: error: for each function it appears
in.)
make[1]: *** [arch/arm/mach-omap1/clock.o] Error 1
make: *** [arch/arm/mach-omap1] Error 2

Cheers,
Jon
