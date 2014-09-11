From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] omap mailbox changes for v3.18 merge window
Date: Thu, 11 Sep 2014 16:28:57 -0700
Message-ID: <20660.4462386624$1410478227@news.gmane.org>
References: <pull-1410478051-378788>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1410478051-378788>
In-Reply-To: <pull-1410478051-378788>
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

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/mailbox-for-v3.18

for you to fetch changes up to 75288cc66dc478b32e43970dd6913396526504ae:

  mailbox/omap: add support for parsing dt devices (2014-09-11 11:39:14 -0700)

----------------------------------------------------------------
Mailbox related changes for omaps to get it to work with
device tree.

----------------------------------------------------------------
Suman Anna (2):
      Documentation: dt: add omap mailbox bindings
      mailbox/omap: add support for parsing dt devices

 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 108 ++++++++++++++
 drivers/mailbox/omap-mailbox.c                     | 156 +++++++++++++++++----
 2 files changed, 240 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
