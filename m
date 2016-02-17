From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of hwmod fixes and additions for
 v4.6
Date: Wed, 17 Feb 2016 18:41:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602171838420.11377@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6/omap-hwmod-a

for you to fetch changes up to 8fe097a3d99e22355fb8e3bcee59542bf3f46b2d:

  ARM: DRA7: hwmod: Add reset data for PCIe (2016-02-09 02:18:52 -0700)

- ----------------------------------------------------------------
ARM: OMAP2+: first set of hwmod fixes and additions for v4.6

A few fixes for OMAP hwmod data.  SSI hwmod data for the OMAP 3730,
and some fixes for the DRA7xx hwmod data.  These shouldn't interfere
or impact anything else.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.6/20160214161224/

- ----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
      ARM: DRA7: hwmod: Add reset data for PCIe

Sebastian Reichel (1):
      ARM: OMAP2+: hwmod data: Add SSI data for omap36xx

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 +++++++------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 18 ++++++++++++++++--
 arch/arm/mach-omap2/prm7xx.h               |  1 +
 3 files changed, 24 insertions(+), 8 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWxL6zAAoJEMePsQ0LvSpL1MkQAKazzSI2wEHMKXyDyk7T3YAt
ADhkrDJP0ukp2PVonis2/tlPMwiz5ZABnZ3tbnUeugcyX0ndpzAGVq/DEG1WeHQb
gjo3rw3y6/oh6W9b0GLofLeMiI4hoq1bpsHTanEUgTLu6cPoDWsMET+CuQc5tzO9
Rwek2O6qNDO/f+U+duArXObLRrPDJFpT8M8Q7YX7EhI9mSoBb5laPQ1atrDCglRE
UwZBZZUpEdpeaH/gDEVEvnwFvK/SbsknSUQ8kTRNgaEH0fmHoN/LHsWWqIfhNL9C
+mmDkvOTS5QBcH2XTL/yHuuKP6Yz93JIgXtkGe1E5tL5OF4wgk2i9CPqk72vEZwN
Tax0g2B2Yg1yz6I1WZhTu6lpU3FWJ6NC0jL7/iRGncapxjdm3KipiC1qfA6wjqv6
14+Jfr2nji/REbEteiQP7jwysb65UJDWLZOibZm8iwH8eaT5Gv4IzQbfOkU2f8tJ
/EmD0RQ+q67kCAxIzuQTfHJLDVBt1040qf+fr7krzVwnujWkFO4jYSfMQy5Ieb/x
4L0qcXANAtzqxdRUx+gW/16YBLoiQJ4oZnJa+Hw5RwMIzSszTP1lKNpq1hLt/ZuU
jebOXaLAJKWdINseXJVzSJ5lh2pD/lYhC0aT/ukQGVaaxbHlFNYbpMXjxtXCGieN
vzCJhDnE4VH3QLcUmoWf
=Qyj4
-----END PGP SIGNATURE-----
