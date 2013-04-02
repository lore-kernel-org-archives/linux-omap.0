From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap hw crypto updates for v3.10 merge window
Date: Tue, 2 Apr 2013 10:29:11 -0700
Message-ID: <E1UN51e-0001qW-Lr@merlin.infradead.org>
References: <pull-1364923751-842943>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1364923751-842943>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 78e52e026d288aad88b46bff0d94b05e145c4583:

  ARM: OMAP2+: clock data: Remove CK_* flags (2013-03-18 09:57:39 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/crypto-signed

for you to fetch changes up to f13acab6594451da8b5bd39db0c0513aba592a8d:

  Merge tag 'omap-devel-a-for-3.10' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.10/crypto (2013-04-01 10:07:28 -0700)

----------------------------------------------------------------

Omap crypto related bus level changes via Paul Walmsley <paul@pwsan.com>:

For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
code and data to use hwmod and omap_device. This is a prerequisite for
moving the hwmod code out of arch/arm.

Basic test logs are available at:

http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.10/20130330155313/

----------------------------------------------------------------
Mark A. Greer (13):
      ARM: OMAP2xxx: hwmod: Convert SHAM crypto device data to hwmod
      ARM: OMAP2xxx: hwmod: Add DMA support for SHAM module
      ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to hwmod
      ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
      ARM: OMAP2+: Only manually add hwmod data when DT not used.
      ARM: AM33XX: Add sha0 crypto clock data
      ARM: AM33XX: hwmod: Update and uncomment SHA0 module data
      ARM: OMAP2xxx: hwmod: Convert AES crypto devcie data to hwmod
      ARM: OMAP3xxx: hwmod: Convert AES crypto device data to hwmod
      ARM: OMAP2+: Remove unnecessary message when no AES IP is present
      ARM: OMAP2+: Only manually add hwmod data when DT not used.
      ARM: AM33XX: Add aes0 crypto clock data
      ARM: AM33XX: hwmod: Update and uncomment AES0 module data

Tony Lindgren (1):
      Merge tag 'omap-devel-a-for-3.10' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.10/crypto

 arch/arm/mach-omap2/cclock2430_data.c              |   4 +-
 arch/arm/mach-omap2/cclock33xx_data.c              |  10 ++
 arch/arm/mach-omap2/cclock3xxx_data.c              |   2 +
 arch/arm/mach-omap2/devices.c                      | 149 +++---------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  36 +++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  81 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  92 +++++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 172 +++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   4 +
 11 files changed, 401 insertions(+), 153 deletions(-)
