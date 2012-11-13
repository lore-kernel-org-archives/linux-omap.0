From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 0/5] staging: omap-thermal fixes
Date: Tue, 13 Nov 2012 14:09:59 -0400
Message-ID: <1352830204-21546-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello again Greg,

So here is the correct set of changes. They now include the
right version of the patches and with the fixes reported
by Enric. Thanks Enric for the heads up.

So, Several compilation fixes and a couple of debugging prints
added to the omap-thermal driver under staging area.

Patches are also available here:

git@gitorious.org:thermal-framework/thermal-framework.git thermal_work/omap/omap-thermal-fixes_3.7


Cheers,

Eduardo Valentin (4):
  staging: omap-thermal: fix compilation
  staging: omap-thermal: remove platform data nomenclature
  staging: omap-thermal: remove freq_clip table
  staging: omap-thermal: add IRQ debugging messaging

Radhesh Fadnis (1):
  staging: omap-thermal: fix context restore function

 drivers/staging/omap-thermal/omap-bandgap.c        |   63 ++++++++----------
 drivers/staging/omap-thermal/omap-bandgap.h        |    9 ---
 drivers/staging/omap-thermal/omap-thermal-common.c |   69 ++------------------
 3 files changed, 33 insertions(+), 108 deletions(-)

-- 
1.7.7.1.488.ge8e1c
