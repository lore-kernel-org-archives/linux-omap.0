From: Christoph Hellwig <hch@lst.de>
Subject: Re: remoteproc: don't allow modular build
Date: Thu, 19 Sep 2019 19:47:24 +0200
Message-ID: <20190919174724.GB9622@lst.de>
References: <5bf9425f-4ea0-09db-70cc-415ac0031b95@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5bf9425f-4ea0-09db-70cc-415ac0031b95@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: hch@lst.de, bjorn.andersson@linaro.org, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 19, 2019 at 11:01:35AM +0530, Keerthy wrote:
> Hi Christoph/Bjorn,
>
> There are a bunch of defconfigs that rely on modular build of remoteproc.
>
> If i do a git grep CONFIG_REMOTEPROC on linux-next:
>
> arch/arm/configs/davinci_all_defconfig:CONFIG_REMOTEPROC=m
> arch/arm/configs/multi_v7_defconfig:CONFIG_REMOTEPROC=m
> arch/arm/configs/omap2plus_defconfig:CONFIG_REMOTEPROC=m
> arch/arm/configs/qcom_defconfig:CONFIG_REMOTEPROC=y
> arch/arm64/configs/defconfig:CONFIG_REMOTEPROC=m
>
> All of them now stop building the remoteproc as a module and all the 
> dependent modules consequently do not get built. Do you recommend all of 
> them to get converted to built in?

Yes, I guess we need to do that.
