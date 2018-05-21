From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] ti-sysc array access fix for v4.18 merge window
Date: Mon, 21 May 2018 12:41:30 -0700
Message-ID: <pull-1526925630-789198@atomide.com>
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

The following changes since commit dc4c85eac6bc8cfe25144936c5636aa1415bbc12:

  bus: ti-sysc: Show module information for suspend if DEBUG is enabled (2018-05-01 06:54:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/ti-sysc-fix-signed

for you to fetch changes up to c97c8620833e4a55ddb7a43961d3205184a487f0:

  bus: ti-sysc: Fix optional clocks array access (2018-05-18 07:54:44 -0700)

----------------------------------------------------------------
One ti-sysc fix for v4.18 merge window

This fixes an array access errors if there are more optional clocks
than one.

----------------------------------------------------------------
Tony Lindgren (1):
      bus: ti-sysc: Fix optional clocks array access

 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
