From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] urgent omap related x86 pinctrl build fix for v3.13 merge
 window
Date: Fri, 18 Oct 2013 17:26:32 -0700
Message-ID: <7726.74662662229$1382142435@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit dc7743aa3c49fabbc6dc9edbcf7df74d776ac32e:

  pinctrl: single: Add support for auxdata (2013-10-10 15:30:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/pinctrl-fix

for you to fetch changes up to 1b9c0fb365cbb1154f4e7997061db972cbf58300:

  pinctrl: single: Fix build when not built on ARM (2013-10-18 16:43:06 -0700)

----------------------------------------------------------------
Looks like I managed to break the x86 build for some
configs. Here's a fix for that on top of the pinctrl
changes already merged with the signed tag
omap-for-v3.13/quirk-signed.

----------------------------------------------------------------
Tony Lindgren (1):
      pinctrl: single: Fix build when not built on ARM

 drivers/pinctrl/pinctrl-single.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
