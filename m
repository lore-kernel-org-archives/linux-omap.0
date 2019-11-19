From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/15] Remoteproc: updates for OMAP remoteproc support
Date: Tue, 19 Nov 2019 16:16:30 +0200
Message-ID: <20191119141645.19777-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

This is v2 of the series [1], addressing comments from Bjorn and Rob.
Bindings patch is funnily v2.5, as I posted v2 already and wanted to
keep this somehow in sync. Individual patches contain comments about the
changes, or Reviewed-by tags provided if there are no changes.

I also dropped the conversion patch to SPDX licensing until I can
confirm the license we want to use. Lets just keep the existing in place
until that.

This series still depends on the reset + clock patches posted earlier,
but both of those dependencies are in linux-next now.

-Tero

[1] https://patchwork.kernel.org/cover/11215421/



--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
