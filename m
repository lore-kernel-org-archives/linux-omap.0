From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of hwmod changes for v4.7
Date: Sun, 17 Apr 2016 00:06:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604170005480.13961@utopia.booyaka.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Tony

The following changes since commit 1cbabcb9807e31e87ef3a12af76ea025ceb582d3:

  ARM: DRA7: clockdomain: Implement timer workaround for errata i874 (2016-04-10 11:43:57 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.7/omap-hwmod-a

for you to fetch changes up to c20c8f750d9f8f8617f07ee2352d3ff560e66bc2:

  ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check sequence (2016-04-10 13:20:11 -0600)

- ----------------------------------------------------------------
ARM: OMAP2+: first set of hwmod changes for v4.7

For the DRA7xx platform, add IP block data for the McASP, PWMSS,
and GPTimer12 IP blocks.  Add lock and unlock functions for the
RTC IP blocks on the DRA7xx, AM33xx, and AM43xx devices.  And add
a fix for the hwmod core for device driver unbind operations for
IP blocks with hardreset lines.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.7/20160410132119/

Note that the testbed here does not have the DRA7xx board included yet.

- ----------------------------------------------------------------
Lokesh Vutla (3):
      ARM: OMAP2+: hwmod: RTC: Add lock and unlock functions
      ARM: DRA7: RTC: Add lock and unlock functions
      ARM: AMx3xx: RTC: Add lock and unlock functions

Peter Ujfalusi (1):
      ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8

Suman Anna (2):
      ARM: DRA7: hwmod: Add data for GPTimer 12
      ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check sequence

Vignesh R (1):
      ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS

 arch/arm/mach-omap2/omap_hwmod.c                   |  12 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 364 ++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_reset.c             |  65 ++++
 5 files changed, 437 insertions(+), 8 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXEtNJAAoJEMePsQ0LvSpL89kP/2AY5KsAVaK15LeDxA1a0ZRq
3dsYeuN/1t5irB8IFI/8190B3LKDkPQLV7aNhUUBO0HrtjhfEWHiGHV5n0BvrpYQ
YC20C961HKRQkQVbBb1VMLeBVPdaqpkMYs+0DHCVb0c/p4/FJ/PnbJm583jPbnbS
8DzTNdjkcpL+oKJ8dK71KMbWm5sCLReJFq5aFZ+FICcmd/iWk6XR51jNIHRSt0tl
p01whhVhcmv85OmWLKSOwtSi+ANqCOw8nARxwA7LvYj5zQ7p/KnKpBFgWvEo0HL1
pbPkh9hgSE6BddTFHpkOwqvnpvWvHKXPnn90VNye45snoWFPhMetrM8gIEZTChY9
PznS8ew1l3JA7As6aCu1t6uqVJ8znfhS/fGui/bArZRAJn0nbMj3oMPzqxUckRjh
7RIAaFGJINdMBcjqe0R9Hdeop5DDS0lgVWqETVW+IKLFMjEWvMOrbRVWk7Ce2Dh7
S8zo0nE8Se91vQMRM/Ngr1P6fzEEUY9t8fwsOxAbOdeX3uZ4nAhxjOYOmSAYaDgx
GrOEPWrOn/REw2KPQp93XGTLWL7JGorX++zK8lhHs8AUCumh0nrezYBTO4VjlzEd
UjVvhO0tiMh/93lk6B7E59BIpVgql0wZ59mt4aFN7RU7blnsNxAQyG6q6ajAw7Rw
FRtjzA4tOLckGmYDg+Vz
=KAJc
-----END PGP SIGNATURE-----
