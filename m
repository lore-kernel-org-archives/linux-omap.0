From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] reworked fix for earlier ti81xx changes for v4.5 merge
 window
Date: Tue, 22 Dec 2015 17:44:45 -0800
Message-ID: <47739.5502770834$1450835161@news.gmane.org>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are reworked pull requests to separate the dts changes as requested
by Olof.

The pull request below, and the third pull request in this series,
still depend on the earlier branch omap-for-v4.5/81xx-fixes-signed.
The pull request number two in this series does not.

My updated for-next has zero diff with these merged in compared to the
earlier single branch merged in, so this is just regrouping of the patches
into three separate pull requests.

Regards,

Tony


The following changes since commit d893656e61040f3ff7b5f72a986052a348f3c94e:

  ARM: OMAP2+: Remove useless check for legacy booting for dm814x (2015-12-09 16:53:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/81xx-fix-signed

for you to fetch changes up to dbb7e70a69288980c8a89fdb5ffb97e06b806b19:

  ARM: OMAP2+: Fix randconfig build warning for dm814_pllss_data (2015-12-22 17:01:02 -0800)

----------------------------------------------------------------
Fix a randconfig build warning introduced in the earlier branch
omap-for-v4.5/81xx-fixes-signed.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: OMAP2+: Fix randconfig build warning for dm814_pllss_data

 arch/arm/mach-omap2/prm_common.c | 2 ++
 1 file changed, 2 insertions(+)
