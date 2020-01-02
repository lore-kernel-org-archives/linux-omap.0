From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 00/14] remoteproc: updates for omap remoteproc support
Date: Thu, 2 Jan 2020 15:18:31 +0200
Message-ID: <20200102131845.12992-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

This version addresses any review comments received for v3. Detailed
change logs are added to individual patches, but the main changes are:

- moved a few config options to DT
- PM runtime sequencing cleanup up
- device memory data moved under single structure for clarity
- some error handling fixes / hardening

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
