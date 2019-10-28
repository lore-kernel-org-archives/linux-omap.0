From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/17] remoteproc: omap changes on top of v5.4-rc1
Date: Mon, 28 Oct 2019 14:42:21 +0200
Message-ID: <20191028124238.19224-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

Mostly this is a facelift of the pretty old OMAP remoteproc code base,
supporting now DT, runtime PM, ti-sysc, and dropping legacy omap hwmod
support. Also timer + watchdog support is added, and couple of bugfixes.

The series hasn't been posted before mostly due to missing OMAP reset
support, which has just been lately posted out and is getting merged to
5.5.

For proper functionality, this series depends at least on the clock [1]
and reset [2] series sent out by me, but to compile, it only needs [1].

-Tero

[1] TI Clock series: https://patchwork.kernel.org/cover/11143025/
[2] TI Reset series: https://patchwork.kernel.org/cover/11179573/


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
