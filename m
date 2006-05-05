From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: Touchscreen on Innovator OMAP1510
Date: Fri, 5 May 2006 17:37:25 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C0936A8@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

=20

I am using the latest git (2.6), with 3.4.1 toolchain.  I am trying to
configure the kernel for touchscreen support.  I enable the touchscreen
in the kernel in the following way,

Drivers->Input Device Support -> touchscreen interface

=3D=3D>     event interface

=3D=3D>     Touchscreens -> OMAP touchscreen input driver

=20

After doing this when I cross compile I get the error
"CONFIG_ARCH_OMAP16XX" is not defined and also tsc2101_write function
generates error.

Innovator has ADS7846E as touchscreen controller.  How to enable the
driver for ads7846 instead of tsc2101?

Also what is the source of CONFIG_ARCH_OMAP16XX not defined?

I am putting the error messages below.  Hope someone will know the
source of these errors.

=20

Thanks in advance

Regards

Prakash

drivers/ssi/omap-tsc2101.c:42:5: warning: "CONFIG_ARCH_OMAP16XX" is not
defined
drivers/ssi/omap-tsc2101.c:45:2: #error "Unsupported configuration"
drivers/ssi/omap-tsc2101.c: In function `omap_tsc2101_write':
drivers/ssi/omap-tsc2101.c:136: warning: implicit declaration of
function `omap_uwire_data_transfer'
drivers/ssi/omap-tsc2101.c: In function `omap_tsc2101_configure':
drivers/ssi/omap-tsc2101.c:222: error: `UWIRE_READ_RISING_EDGE'
undeclared (first use in this function)
drivers/ssi/omap-tsc2101.c:222: error: (Each undeclared identifier is
reported only once
drivers/ssi/omap-tsc2101.c:222: error: for each function it appears in.)
drivers/ssi/omap-tsc2101.c:222: error: `UWIRE_WRITE_RISING_EDGE'
undeclared (first use in this function)
drivers/ssi/omap-tsc2101.c:224: warning: implicit declaration of
function `omap_uwire_configure_mode'=20

=20
