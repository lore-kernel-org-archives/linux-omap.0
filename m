From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: booting process
Date: Wed, 31 May 2006 18:11:31 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E133FAE@DLEE09.ent.ti.com>
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
To: lvcargnini@ieee.org, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Luis,
> After Mr. Luis Ries asked me i published the last e-mails exchanged
> with "Menon, Nishanth"  on list
<snip>
> jffs2_scan_eraseblock(): Node at 0x00dc0000 {0x1985, 0x2001,
> 0x00000008) has invalid CRC 0x640620a0 (calculated 0x26b486ed)
>  jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at
> 0x00dc0004: 0x0008 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0008:
> 0x20a0 instead
To repeat what I suggested:
Try this:
ftp://ftp.infradead.org/pub/mtd-utils/mtd-utils-1.0.0.tar.gz
from http://www.linux-mtd.infradead.org/

u need to cross compile it for arm platform with the kernel path is
properly given.. most probably the mkfs.jffs2 is the wrong version... I
suspect ur using the latest kernel from git tree...

Regards,

Nishanth Menon
