From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 0/5] FIFO caused playback delay (latency) handling in soc/omap
Date: Wed,  3 Mar 2010 15:08:03 +0200
Message-ID: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32606 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0CCNJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:09:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com

Hello,

Changes since the RFC round on the alsa-devel list:
- core is not limiting the query for the delay to the playback stream.
  It is no the dai and platform driver's responsibility handle that
- delay interface added for platform driver
- Capture path delay calculation is added to OMAP McBSP.
- omap_mcbsp_get_tx_buffstat renamed as omap_mcbsp_get_tx_delay to reflect what
  it is actually doing.

Tony: is it still possible to get this taken for 2.6.34? It would be nice to
avoid cross tree problems during the 34 cycle...

The initial RFC patch description:

There has been discussion in alsa-devel in this subject several times,
but no actual patches has been sent (it was not soc related, but anyway it was
discussed).

Based on the available information the latency caused by the HW buffer
on some systems can be handled by updating the runtime->delay.

It has been discussed, that the runtime->delay can also be updated
dynamically to show more accurate delay.

To further complicate things, in ASoC we could have more buffer in the
chain. To handle this we need soc level support.

This series tries to do that in soc by:
- introducing a pcm_pointer wrapper
- in this wrapper we call the original pcm_pointer functions to get the
  DMA pointer
- introducing a new interface in dai_ops and for platfrom drivers to ask the
  delay
- adding the cpu_dai, codec_dai and platform driver returned delay to form
  the actual delay
- update the runtime->delay with this value.

With this approach none of the existing drivers need change, but they
can add support for specifying the FIFO caused delay.

In this series on top of the core changes the omap(3) code is updated
to take this delay reporting into use.
I have not added the support to the tlv320dac33 codec driver, since it
needs a bit more work, but along the same line it can be done, and if
the tlv320dac33 is hooked to omap McBSP than applications can know the
whole delay/latency on that path.

The series is based on linux-omap master branch (with regcache and sidetone).
However the first 3 patch for soc core applies on top of sound-2.6 topic/asoc
cleanly as well.
Obviously the last patch depends on the OMAP platform patch.

---
Peter Ujfalusi (5):
  ASoC: core: fix tailing whitespace in soc_pcm_apply_symmetry
  ASoC: core: soc level wrapper for pcm_pointer callback
  ASoC: core: Add delay operation to snd_soc_dai_ops
  OMAP3: McBSP: Add interface for FIFO caused delay query
  ASoC: OMAP3: Report delay caused by the internal FIFO

 arch/arm/plat-omap/include/plat/mcbsp.h |    6 +++
 arch/arm/plat-omap/mcbsp.c              |   55 +++++++++++++++++++++++++++++++
 include/sound/soc-dai.h                 |    6 +++
 include/sound/soc.h                     |    7 ++++
 sound/soc/omap/omap-mcbsp.c             |   26 ++++++++++++++
 sound/soc/soc-core.c                    |   39 +++++++++++++++++++++-
 6 files changed, 137 insertions(+), 2 deletions(-)

