From: "Lucas Hartmann" <lucas.hartmann@gmail.com>
Subject: Receiving error "Failed to open an initial console." Serial driver?
Date: Wed, 22 Mar 2006 22:04:20 -0300
Message-ID: <2a3728820603221704y751e2920q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hello.

I'm getting an error "Failed to open an initial console" while trying to
boot linux kernel 2.6.15 + omap1 patch from muru.com.

By adding a few lines of code right before the warning message (init/main.c=
)
I've noticed that there are no /dev/console or /dev/ttyS0 files. I guess th=
e
serial driver was not selected for compilation... I used make
innovator_omap1510_defconfig (or something like this) to configure the
kernel... If this may be it, where can I find the driver in make menuconfig=
?

The nfs root is mounted and /dev folder is present (don't know about the
remaining device nodes).
I'm using scratchbox 1.0 and kubuntu 5.10 on the PC, for setting up the NFS
root filesystem and kernel compilation.

I'm new to OMAP development and to this list. If this is an off-topic,
please let me know in PVT, so that I can look for the right place to ask.

Thanks.
--
Lucas Vinicius Hartmann

"There are 10 kinds of people in the world: The ones who understand binary
and the ones who don't."
