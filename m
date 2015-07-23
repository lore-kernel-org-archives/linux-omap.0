From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod fixes for v4.2-rc
Date: Thu, 23 Jul 2015 13:57:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507231357020.29543@utopia.booyaka.com>
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

Hi Tony,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.2-rc/omap-fixes-a

for you to fetch changes up to 9a258afa928b45e6dd2efcac46ccf7eea705d35a:

  ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods without sysc (2015-07-23 06:35:25 -0600)

- ----------------------------------------------------------------
ARM: OMAP2+: hwmod fixes for v4.2-rc

Two fixes against v4.2-rc1.  The first, for DRA7xx platforms,
corrects some incorrect GPMC hardware description data.  The
second one will ensure that the hwmod code will wait for any
module with CPU-accessible registers to become ready before
attempting to access it.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.2-rc/20150723065408/

Note that I do not have a DRA7xx or AM43xx board, and therefore
cannot test on those platforms.

- ----------------------------------------------------------------
Roger Quadros (2):
      ARM: DRA7: hwmod: fix gpmc hwmod
      ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods without sysc

 arch/arm/mach-omap2/omap_hwmod.c          | 24 ++++++++++++++++--------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  5 ++---
 2 files changed, 18 insertions(+), 11 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVsPKkAAoJEMePsQ0LvSpLcXoP/1WSdYaC65HEPHJjDV3Wpq5L
vKmjqXnLiYzcpdjX7ByTa0SiUwMRNie4P0N1Zm0yTjRCoJIrnmAI/GB9ZXq/E7wN
RTTZoEaq+Cqt69JY4xySL8ASTgXPMZkelNOH9JO8/yMWHKE3WEDnhDJ32QN/3Isf
WF7GDJQC/utlHS4BgFoQBpBv2LSgrqrt+TsX1CKqWhvVTd4moPNBXtNoCb7VC5P3
ciuUWNFi4y+g1zAPyhe/Q1bzRyDRefEFUesyRx3aHGpTd3VLHWvSK9tEqSjt+EM4
LA/l5lRHjAFcTGuSBRytpE1zhPW7+gSWgFLsJYDnfXmo7Sp9IgFr3Dcbcj++Sbj0
HD64ZXQPfn0WRPphZNh8h6+KWVfXv9x8pLmAzy7zn2w7qPBEWMurjbdvUSF2aczZ
tU+kf+YAyOwA36Goj+NeBqdno0lHPU7++HeHywx5znNFpExqQ+r/T0pOqAmDxPJS
PFUSE67ax+AkIyS9syCaTDYrj3Al5pOvqjWdMgtETKZdfDbK1r5dFdv+ywO1hIKj
Y5/n8rBfRZRL33Y6pd/kvEf9y7vMgMMhUDfEX1QJoh0karrvLPJGtBQhRs11n11Q
PZ+MOh5I6ZPz3zTlcAyCqKVeebcJN5DQmuntuK3raDDllPGGrgPO2vNsjbqSC9DO
+z4jg0SH51c0LgK/Eum5
=UnJq
-----END PGP SIGNATURE-----
