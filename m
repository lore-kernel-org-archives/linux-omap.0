From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap gpmc null pointer fix against v4.2-rc6
Date: Thu, 13 Aug 2015 01:20:22 -0700
Message-ID: <20150813082022.GL10928@atomide.com>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit cd4556733b30cc363adc7b1cea3bffa7e2dd0c7c:

  ARM: dts: dra7: Fix broken pbias device creation (2015-08-05 03:04:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc6

for you to fetch changes up to e984a1791ac6a7c944911207e8a9c344763f0003:

  memory: omap-gpmc: Don't try to save uninitialized GPMC context (2015-08-12 01:43:49 -0700)

----------------------------------------------------------------
Fix a NULL pointer exception for omap GPMC bus code if probe fails.

----------------------------------------------------------------
Tomeu Vizoso (1):
      memory: omap-gpmc: Don't try to save uninitialized GPMC context

 drivers/memory/omap-gpmc.c | 6 ++++++
 1 file changed, 6 insertions(+)
