From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/7] omap serial pm cleanup for v3.11 merge window
Date: Tue, 18 Jun 2013 11:07:25 -0700
Message-ID: <E1Up0Ke-0007tL-HS@merlin.infradead.org>
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

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/pm-serial-signed

for you to fetch changes up to 1e383d7bdd988b1453a3a86f5e14b012700f7dff:

  Merge tag 'omap-pm-v3.11/cleanup/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.11/pm-serial (2013-06-17 04:03:14 -0700)

----------------------------------------------------------------

Serial driver platform init code clean-up via Kevin Hilman <khilman@linaro.org>:

OMAP: PM: the serial core + driver can no handle no_console_suspend support
without any SoC specific handlding or SoC-specific DT bindings.  Remove
the now unused SoC specifics for OMAP.

----------------------------------------------------------------
Sourav Poddar (3):
      arm: omap2+: serial: remove no_console_suspend support
      arm: dts: am33xx: Remove "ti,no_idle_on_suspend" property.
      arm: omap2+: omap_device: remove no_idle_on_suspend

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.11/cleanup/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.11/pm-serial

 arch/arm/boot/dts/am33xx.dtsi     |  1 -
 arch/arm/mach-omap2/omap_device.c |  9 ++-------
 arch/arm/mach-omap2/omap_device.h | 10 ----------
 arch/arm/mach-omap2/serial.c      |  7 -------
 4 files changed, 2 insertions(+), 25 deletions(-)
