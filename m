From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 0/2] Add mt9t001 and tvp5150 support to cm-t3x board.
Date: Wed, 13 Jun 2012 15:55:08 +0300
Message-ID: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch set adds mt9t001 camera sensor and tvp5150 video decoder registration to 
cm-t35/cm-t3730 board support file. Base board (SB-T35) CIP of cm-t3x module can be 
connected to external video input adapter like Compulab VIP-ADP board.

VIP-ADP has a digital camera sensor connection port and two composite video input ports.
Analog composite video is processed by TVP5151 NTSC/PAL/SECAM Video Decoder chip.

Dmitry Lifshitz (2):
  ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
  ARM: OMAP3: cm-t35: add tvp5150 decoder support

 arch/arm/mach-omap2/board-cm-t35.c |   89 ++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

-- 
1.7.5.4
