From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first hwmod fix for v4.6-rc
Date: Tue, 29 Mar 2016 06:48:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603290647170.20409@utopia.booyaka.com>
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

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6-rc/omap-fixes-a

for you to fetch changes up to 3ca4a238106dedc285193ee47f494a6584b6fd2f:

  ARM: OMAP2+: hwmod: Fix updating of sysconfig register (2016-03-26 23:08:55 -0600)

- ----------------------------------------------------------------
ARM: OMAP2+: first hwmod fix for v4.6-rc

Fix a longstanding bug in the hwmod code that could cause
hardware SYSCONFIG register values to not match the kernel's
idea of what they should be, and that could result in lower
performance during IP block idle entry.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-fixes-a-for-v4.6-rc/20160326231727/

- ----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: OMAP2+: hwmod: Fix updating of sysconfig register

 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+GgPAAoJEMePsQ0LvSpLO0MP/2DtDpbR/5jn+D9TNNkmhZed
RAkY7etiSX9uMz65R8MzH7+G6D0p22VF66DdKR/d4ewv4n4YK+4swMRn3VZ/AZKJ
ZJNSdu1P9jLPQYvxmD7k/pdbQPZ8NuhCRR5j8CyLOEzPPZfRFDC4RIgddgKuPbaU
tpAInuPZ/PJj9xBWUAShJa1ZgZABm3+ivkybw3SJSiQpwROf45W2pkQUXgEeRV+R
kmWmsav9TBCMNnJyxKlI4bPkU/RXaHkksfFEOuXSG5sNhSfjgGy9RgCXSE6gTi5K
Qw/I3wyqa8VxZSg7JxXG0rkq63jUpywH3BB1dXBhZ5cb+6DdI3Kpqe+j8gYbMH8W
60WFHPiIqghfT2pvqQw8PXOp61SeaUu5N/AWUK7gfIDDW1iq0hHTFXnXflW6K709
IhoRsn0bazuFhIAHLy3R5ZsZRE3RDr1JYum2n0Q1cJBiKP47kpcGVCqPpddGue+p
ZEg+M67EdvLfKLC3KEzT0X2zJCCi8Z1IGOzHIOt4mG2TnyPDU5rZR+QSp7Oi6vdz
Z82eKW9cCg+WAJjxw0KoMJIVqbzp9FQWGoJiY883BF+tP2tkY9c2/pUrPaTaDO3m
ajy9NUsPTHBqQd+DiEj1BUucu2LFj5vfPEBlASGeUcfkASePN+jG1M/bcmqcMx5F
JnZRdouLjoSLQNNOeujA
=HOgc
-----END PGP SIGNATURE-----
