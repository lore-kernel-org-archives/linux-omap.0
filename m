From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/28] clk: ti: clkctrl fixes + support for new SoCs
Date: Thu, 9 Nov 2017 11:15:13 +0200
Message-ID: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi,

Just posting the updated patches compared to previous version of the
series. Patches from #7+ have just their number incremented by one due
to the additional patch #5, not reposting these.

Changes compared to v1:
- added more comments to patch #4, and improved commit message
- added patch #5 which converts the retry init user data to void * ptr
- modified old patch #5 (new #6) to use the new parameter type for retry
- added am438x-epos support to patch #23.

Updated branch pushed here:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: 4.14-rc1-clkctrl-driver-v2

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
