From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 6/7] omap gpmc reworked suspend patch for v3.11 merge window
Date: Tue, 18 Jun 2013 11:07:27 -0700
Message-ID: <E1Up0KW-0007sw-UA@merlin.infradead.org>
References: <pull-1371578847-800598>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1371578847-800598>
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

The following changes since commit b3f5525c55ce5cb67af06f04dbbf28358da23a2c:

  ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable (2013-06-12 09:56:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/gpmc-part2-signed

for you to fetch changes up to b536dd412b4364df2f9495c6550ee38f6ad3b0fe:

  ARM: OMAP2+: gpmc: Low power transition support (2013-06-18 03:46:39 -0700)

----------------------------------------------------------------
GPMC suspend patch that was left out of the earlier
omap-for-v3.11/gpmc-signed branch because of a compile error
it caused. The compile error is fixed in this version.

----------------------------------------------------------------
avinash philip (1):
      ARM: OMAP2+: gpmc: Low power transition support

 arch/arm/mach-omap2/gpmc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)
