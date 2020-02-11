From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 00/14] remoteproc: updates for omap remoteproc support
Date: Tue, 11 Feb 2020 17:21:11 +0200
Message-ID: <20200211152125.23819-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40280 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgBKPVl (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 10:21:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org, afd@ti.com
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org

Hi,

Couple of minor changes on this one, other than that just a rebase to
5.6-rc1:

- converted memory-regions to be an optional property both in the
  binding + driver
- added a warning in the driver if memory-regions are not provided in DT

The above changes only impact patch #1 and #6

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
