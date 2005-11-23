From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: Setting bootargs console=vt100
Date: Wed, 23 Nov 2005 11:17:44 -0000
Message-ID: <002101c5f01f$87300210$642aa8c0@BUFFY>
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

Hi,

=20

First off, I'd like to thank everyone who helped me out earlier. I now =
have
a bootable kernel and can NFS mount my filesystem. Next problem is =
getting
something readable on my serial shell. For many good reasons I am not =
able
to use minicom. The program I am using gives me something like the =
following
as output from "ls":

=20

@[1;34mbin@[0m @[1;34mdev@[0m @[1;34metc@[0m @[1;34mlib@[0m =
@[1;34mproc@[0m

=20

I'm guessing that my terminal can't handle the escape sequences that are
being used to format the output from ls. I know it can handle vt100
correctly. So, how do I force the shell on my ttyS0 to be vt100? Is it
something like:

=20

setenv bootargs console=3DttyS0,115200n8,vt100 ..

=20

fed in to U-boot?

=20

Thanks,

=20

Richard.

=20

=20
