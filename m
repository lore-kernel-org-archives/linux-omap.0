From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: Kernel not working
Date: Mon, 21 Nov 2005 10:48:18 -0000
Message-ID: <004301c5ee89$153ff350$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

=20

I'm a newbie, so please forgive me if this has been answered elsewhere.

I have the 2.6.8rc3 kernel source downloaded from linux.omap.com and =
have
built with GCC 3.3.2. I have not done any tweaking in make xconfig, so =
it
should be the standard OMAP 5912 OSK kernel. I get the vmlinux output =
which
I put through objcopy and the appropriate mkimage for my version of =
Uboot
(1.1.1) to provide me with an image which I tftpboot onto the board.

=20

The system gets as far as uncompressing the kernel and then I get the
message:

=20

Starting kernel .

=20

And nothing else happens.

=20

Can anybody tell me it went wrong and what I can do to try and get it
working please?

=20

I'm sorry if I haven't provided all of the right information for you to =
help
but I'm not sure what I should be providing at this point. If you can =
let me
know.?

=20

Thanks,

=20

Richard.
