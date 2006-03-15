From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: Compiling 2.6.14 for OMAP1510 Innovator
Date: Wed, 15 Mar 2006 17:21:52 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C093656@edpc500.cedt.iisc.ernet.in>
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

Hai all

=20

I am trying to compile kernel 2.6.14 with omap1 patch downloaded from
muru.com. I am using 3.4.1 toolchain. I am facing the  following problem
in compiling.  While compiling for OMAP15XX, I set "CONFIG_ARCH_OMAP16XX
is not set" in .config.  Now the following warning/error comes in
compiling.

=20


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
function `omap_uwire_configure_mode'
make[2]: *** [drivers/ssi/omap-tsc2101.o] Error 1
make[1]: *** [drivers/ssi] Error 2
make: *** [drivers] Error 2

=20

=20

Now if I enable CONFIG_ARCH_OMAP16XX=3Dy also then it forces me to =
enable
UWIRE support also.  Now with both omaap 15xx and omap 16xx enabled the
kernel compiles but fails to boot it simply says =20

=20

"Uncompressing kernel .................... kernel booting "  and then do
not proceed further.

=20

1)      How to disable OMAP16XX ?

2)      Is there a problem if I enable OMAP15XX and OMAP16XX both
together ?

3)      What is the probable source of error for the kernel not coming
up?

=20

Anyone who has encounter the problem or knowing how to proceed further
please help.

Thanks in advance=20

=20

Regards

Prakash

=20

=20
