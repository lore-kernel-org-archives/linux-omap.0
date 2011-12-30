From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/5] Improvements to bq27000 management on OMAP
Date: Fri, 30 Dec 2011 11:58:49 +1100
Message-ID: <20111230004947.11559.81184.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49522 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab1L3Bpb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 20:45:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, Lars-Peter Clausen <lars@metafoo.de>, Rodolfo Giometti <giometti@linux.it>, "Pali =?utf-8?b?Um9ow6FyIg==?= <pali.rohar@gmail.com>@suse.de"@suse.de, Anton Vorontsov <cbouatmailru@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

[re-sent with multiple To: headers to placate vger.kernel.org]

This series makes the bq27000 battery monitor work well
when driven by the HDQ bus on OMAP devices.

I realise that there could be separate maintainers for each
file but figured that the series makes most sense as a whole
and am sending it as such.  If people could take or ACK the
patches relevant to them I would appreciate it.

The first 3 should be uncontroversial.

The fourth:
      omap_hdq: handle case where isr sees a 0 status byte.
fixes a problem that I have experienced, but I don't understand
why it happens.  As the commentary in that patch says, the interrupt
service routine sometimes sees the status as '0' meaning that nothing
caused an interrupt (Inconceivable!!).  This seems to happen in batches
resulting in timeouts that produce many-second delays in reading
battery status from /sys/class/bq27x00_battery/*.

The fifth:
      bq27x00 - don't report power-supply change so often.

Causes the driver to be less noisy to udev.  udev events should be
"uncommon" but the current code triggers a change event (almost) every
time the battery status is read, or every 6 minutes, as it is almost
certain that some value has changed (typically capacity but even
VOLTAGE_NOW can change a little bit).

Thanks,
NeilBrown

---

NeilBrown (5):
      bq27x00 - don't report power-supply change so often.
      omap_hdq: handle case where isr sees a 0 status byte.
      omap_hdq: use wait_event_timeout to wait for read to complete.
      omap_hdq: Fix some error/debug handling.
      Fix w1_bq27000


 drivers/power/bq27x00_battery.c |   15 ++++++++--
 drivers/w1/masters/omap_hdq.c   |   56 +++++++++++++++++++++++++++------------
 drivers/w1/slaves/w1_bq27000.c  |   17 ++++++++----
 3 files changed, 63 insertions(+), 25 deletions(-)

-- 
Signature

