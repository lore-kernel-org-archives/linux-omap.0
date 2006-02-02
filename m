From: "Smith, Stephen" <smsmith@ti.com>
Subject: OSK5912 cpu_is_omap5912() FALSE
Date: Thu, 2 Feb 2006 17:14:14 -0600
Message-ID: <F0A81B25BD70E240B7E341C65A96C833031B6F75@dlee02.ent.ti.com>
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

OSK5912/Linux 2.6.13

=20

There is a discrepancy in cpu.h and what my OSK5912 reflects.

=20

cpu.h reflects:

IS_OMAP_TYPE(5912, 0x1611)

=20

Here is my data from boot, which reflects the correct values:

OMAP_DIE_ID_0: 0xbfd20610

OMAP_DIE_ID_1: 0x8e059089 DIE_REV: 2

OMAP_PRODUCTION_ID_0: 0x00aaaafc

OMAP_PRODUCTION_ID_1: 0x00016cbe JTAG_ID: 0x6cbe

OMAP32_ID_0: 0x03320500

OMAP32_ID_1: 0x2b65f02f

JTAG_ID: 0xb65f DIE_REV: 2

OMAP162123 revision 2 handled as 16xx id: 8e059089bfd20610

=20

=20

Is arch-omap/cpu.h wrong, or is there something more here?  With

code as it was patched, cpu_is_omap5912() fails.  Sign of problem

is the inability to reboot the board (# reboot).  I can fix by

changing cpu.h to:

=20

IS_OMAP_TYPE(5912, 0x1621)

=20

I don't want to blindly change because I do not know history of OMAP5912

and it is possible some previous rev had id'ed as 1611.

It could also be fixed by adding another type check to arch_reset(), but

that may include 1621 types that do not require or want workaround.

=20

Any insight would be appreciated.

=20

Thanks,

Stephen
