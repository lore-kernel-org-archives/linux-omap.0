From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v5 0/5] OMAP/ASoC: McBSP: FIFO handling related fixes
Date: Thu,  3 Jun 2010 07:39:31 +0300
Message-ID: <1275539976-2075-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37192 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab0FCEjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 00:39:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, tony@atomide.com
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Hello,

Tony: Could you take a look at the arch/arm patches in this series?
Thanks!

Changes since v3/4:
- Fixed commit subjects and messages for OMAP3 related patches
- Added Acked-by from Mark, and Jarkko

Intro message from the original series:

This series aims to correct how the McBSP FIFO is viewed, and handled.

Introduction of the problem:
OMAP McBSP FIFO is word structured:
McBSP2 has 1024 + 256 = 1280 word long buffer,
McBSP1,3,4,5 has 128 word long buffer

This means, that the size of the FIFO
depends on the McBSP word size configuration.
For example on McBSP3:
16bit samples: size is 128 * 2 = 256 bytes
32bit samples: size is 128 * 4 = 512 bytes
It is simpler to place constraint for buffer and period based on channels.
McBSP3 as example again (16 or 32 bit samples):
1 channel (mono): size is 128 frames (128 words)
2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
4 channels: size is 128 / 4 = 32 frames (4 * 32 words)

Since now the McBSP codec supports not only 16bit samples (32biut has been
recently added), the FIFO size handling is no longer correct, since it has
been hard wired for 16bit word length.

The series changes how the users of McBSP are configuring the FIFO:
It used to be 0 based (0 meant 1 word threshold). After this series users can
configure the threshold in 1 base mode (1 means 1 word threshold).
The platform code now provides the full size of the FIFO in words, instead of
the already limited value used in the past.

In ASoC omap-mcbsp code hw_rule based constraint refinement is going to be used
instead of the hardwired static constraint, which was correct only in case of
16bit word length.

The hw_rule is refining the minimum buffer size based on the channel number
going to be used by the coming stream.
In case of threshold mode additional hw_rule refines the maximum allowed period
size.

The series are generated agains Takashi's sound-2.6: topic/asoc branch.

CCing also Eduardo, and Eero since they have worked on the original
FIFO/threshold implementation.

All commetns and testers are welcome!
Peter

---
Peter Ujfalusi (5):
  OMAP: McBSP: Function to query the FIFO size
  OMAP3: McBSP: Change the way how the FIFO is handled
  OMAP3: McBSP: Use the port's buffer_size when calculating tx delay
  ASoC: omap-mcbsp: Save, and use wlen for threshold configuration
  ASoC: omap-mcbsp: Place correct constraints for streams

 arch/arm/mach-omap2/mcbsp.c             |   10 ++--
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 +
 arch/arm/plat-omap/mcbsp.c              |   51 ++++++++++-----
 sound/soc/omap/omap-mcbsp.c             |  112 +++++++++++++++++++++++-------
 4 files changed, 128 insertions(+), 47 deletions(-)

