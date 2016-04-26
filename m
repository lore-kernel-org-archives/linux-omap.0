From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH 0/3] AM57/DRA7 Clock Tree DTSI Fix-ups
Date: Tue, 26 Apr 2016 12:54:26 -0500
Message-ID: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series of patches fixes several discrepancies between the
AM57/DRA7 clock tree description and the actual hardware behavior and
frequencies. With these changes a more complete picture of the clock
tree is represented for a few of the clocks and their resulting
frequencies.
