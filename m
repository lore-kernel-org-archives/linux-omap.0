From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 00/14] remoteproc: updates for omap remoteproc support
Date: Thu, 16 Jan 2020 15:53:18 +0200
Message-ID: <20200116135332.7819-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, s-anna@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This version addresses review comments received for v4 of the series.
Mostly cosmetic changes, the most important changes here:

- minor dt binding updates and any driver changes induced by this
- reset handling fixes to avoid asserting/deasserting same reset twice,
  this appeared to still produce some timeouts in some cases; this was
  masked earlier but became visible with one error handling fix

All changes are listed under individual patches.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
