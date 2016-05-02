From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH v2 0/3] AM57/DRA7 Clock Tree DTSI Fix-ups
Date: Mon, 2 May 2016 12:12:00 -0500
Message-ID: <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
References: <20160427171658.GA5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160427171658.GA5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, t-kristo@ti.com, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jay.schroeder@garmin.com
List-Id: linux-omap@vger.kernel.org

This series of patches fixes several discrepancies between the
AM57/DRA7 clock tree description and the actual hardware behavior and
frequencies. With these changes a more complete picture of the clock
tree is represented for a few of the clocks and their resulting
frequencies.

v2 Changes:
* Rebased on linux-next as requested by Tony Lindgren
* Eliminated previous patch 2 as another change fixing the same thing
  was merged in eea08802f586acd6aef377d1b4a541821013cc0b
* Added to the commit message in patch 2 to clarify the source of the
  clock being internal to the processor
* Added a new patch 3 to fix a new warning introduced by
  eea08802f586acd6aef377d1b4a541821013cc0b
