From: <Mikko.Soikkala@Tietoenator.com>
Subject: configuration problem with innovator 1510 & tsc2101
Date: Thu, 19 Jan 2006 11:36:30 +0200
Message-ID: <890E52023811004CB455C1B7C433BA101A8B2B@dino.eu.tieto.com>
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

Hi

=20

I have a problem with 1510 innovator board configuration. If I configure
touchscreen it automatically selects TCS2101 under SSI and then the
compilation fails like this:

=20

  CC      drivers/ssi/omap-tsc2101.o

drivers/ssi/omap-tsc2101.c:42:5: warning: "CONFIG_ARCH_OMAP16XX" is not
defined

drivers/ssi/omap-tsc2101.c:45:2: #error "Unsupported configuration"

=20

I have made a work around for this by compiling the omap-tcs2101.c also
when CONFIG_ARCH_OMAP15XX defined. This seems to work, but I'm unsure if
this is the correct solution.

=20

Is omap-tsc2101.c supposed to be compiled in 1510 innovator environment?

=20

Mikko
