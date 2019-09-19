From: Keerthy <j-keerthy@ti.com>
Subject: remoteproc: don't allow modular build
Date: Thu, 19 Sep 2019 11:01:35 +0530
Message-ID: <5bf9425f-4ea0-09db-70cc-415ac0031b95@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, bjorn.andersson@linaro.org
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Christoph/Bjorn,

There are a bunch of defconfigs that rely on modular build of remoteproc.

If i do a git grep CONFIG_REMOTEPROC on linux-next:

arch/arm/configs/davinci_all_defconfig:CONFIG_REMOTEPROC=m
arch/arm/configs/multi_v7_defconfig:CONFIG_REMOTEPROC=m
arch/arm/configs/omap2plus_defconfig:CONFIG_REMOTEPROC=m
arch/arm/configs/qcom_defconfig:CONFIG_REMOTEPROC=y
arch/arm64/configs/defconfig:CONFIG_REMOTEPROC=m

All of them now stop building the remoteproc as a module and all the 
dependent modules consequently do not get built. Do you recommend all of 
them to get converted to built in?

That will be some magnitude of change.

Best Regards,
Keerthy
