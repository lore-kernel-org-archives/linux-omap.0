From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: second set of hwmod changes for v4.6
Date: Tue, 1 Mar 2016 09:58:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603010958120.14948@utopia.booyaka.com>
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

The following changes since commit 8fe097a3d99e22355fb8e3bcee59542bf3f46b2d:

  ARM: DRA7: hwmod: Add reset data for PCIe (2016-02-09 02:18:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6/omap-hwmod-b

for you to fetch changes up to 34b4182ce5fd284bff38764f8e73e2160b49d8e9:

  ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1 (2016-03-01 01:55:59 -0700)

- ----------------------------------------------------------------
ARM: OMAP2+: second set of hwmod changes for v4.6

These patches add RTC support for the AM43xx, and add support for
the DRA7xx eDMA controller's TPCC, TPTC0, and TPTC1 IP blocks.
Also included is a workaround for PRCM hardreset control of the DRA7xx
PCIe subsystem.

Note that I do not have a DRA7xx board, and therefore cannot
test any patches for that SoC family.

Basic build, boot, and PM test logs can be found here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-b-for-v4.6/20160301021258/

- ----------------------------------------------------------------
Keerthy (1):
      ARM: AM43XX: hwmod: Add rtc hwmod

Peter Ujfalusi (1):
      ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1

Sekhar Nori (1):
      ARM: DRA7: hwmod: Add custom reset handler for PCIeSS

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  14 +++-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 111 +++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1WeoAAoJEMePsQ0LvSpLF2gP/1Lyz4yF9QQrcsroDq8164M1
NbYFWQnR5FzFWrpUZL72/zfn3iZTGWP8+t4Muy3qgjMCwWb2ciB3tX6v2+DL1Agw
xTVeB9EJ6QeMogDELw3A9Fv68ZesIaOn/VnKQqQeAi4FQKi9bfc05+fSF2cQZk5a
SwIqgQbf7bdZc1n4oDDEboQClHjIthYXwdoTtWk4JcUr+6xxF7MnWrQtpEhD/p2n
WwFw8TCAdOu56Y+/wqSmLNdFhHFkPBHDfS7LnDbLD2RVN7iS7QubamixcnjlKEWa
dE8ayf+6PU+l583VjJTGfMm5+fm9g+oyUCkr9eCOVrQGga0/en23/1ag0R9X3fYz
4XNV3ng0PD0q31nvnh9tToGV5Lodhs0cKwx4yg2tcFh1BTvziSZwYeJPpBlgUcjW
I/1SWZ5gaSSZf5EcEXV4Kv7SFx48xvpp95gog5mrqzqQPqz++Z3//gGqiJkcZHh9
Pqk7/s03BUaB2DmXY9+uV1USx3/4biyeOlgTqShtZ5ManmNAlY9+wfwPmpCz6cWW
BpsuEK8T4UQJiiS2mo73g+gxAIF+0uS0doSHaNsJrinX50xd05IxyWOdCEpZTfx1
O/p48BiwRBqTkjvXCSxWBlIMKf6zQb1oeWbkYfx9flnqPbElbvPAG9yNzu10lYah
gbPl8f4LFnKKIXaMVJag
=bfW4
-----END PGP SIGNATURE-----
