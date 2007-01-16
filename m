From: "Juergen Sievers" <JSievers@NADINE-Software.com>
Subject: Help: OMAP5912 RS232 dies after kernel uncompressing.
Date: Tue, 16 Jan 2007 18:22:25 +0100
Message-ID: <001501c73992$e6882900$0700a8c0@NADHHLT01>
Reply-To: JSievers@NADINE-Software.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

Oh, Oh! =20

=20

That is really embarrassing but I found my mistake.=20

=20

I have forgotten to append a =91M=92 to the =91mem=3Dxy=92 statement. So =
my kernel was
thinking there is only 32 byte of memory. =20

Why it still was booting is a miracle too but with =91mem=3D32M=92 it =
works proper
again.

=20

Regards   0(=B0^=B0)0

J.

=20

=20
