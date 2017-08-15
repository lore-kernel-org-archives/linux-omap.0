From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] debug_ll update for omaps for v4.14
Date: Tue, 15 Aug 2017 09:27:27 -0700
Message-ID: <42616.2917087369$1505308695@news.gmane.org>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v4.14/debug-ll

for you to fetch changes up to 51ef70037ebc2f63739c518ef357b364a802b648:

  ARM: debug: Use generic 8250 debug_ll for am3517 and am335x (2017-07-17 00:53:42 -0700)

----------------------------------------------------------------
Tony Lindgren (4):
      ARM: debug: Use generic 8250 debug_ll for omap2 and omap3/4/5 common uarts
      ARM: debug: Use generic 8250 debug_ll for omap3/4/5
      ARM: debug: Use generic 8250 debug_ll for ti81xx
      ARM: debug: Use generic 8250 debug_ll for am3517 and am335x

 arch/arm/Kconfig.debug             |  44 +++++++++++----
 arch/arm/include/debug/omap2plus.S | 108 -------------------------------------
 2 files changed, 33 insertions(+), 119 deletions(-)
