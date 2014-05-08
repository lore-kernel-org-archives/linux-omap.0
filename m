From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL #2/2] ARM: dts: DRA7/AM437x l3noc dts updates
Date: Thu, 8 May 2014 08:04:18 -0700
Message-ID: <20140508150417.GC26833@atomide.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1398698101-25513-1-git-send-email-nm@ti.com>
 <20140505200322.GA9863@kahuna>
 <20140505200635.GB9863@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140505200635.GB9863@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140505 13:07]:
> Hi Tony,
> 
>    Please pull the following to the dts support of AM437x and DRA7
>    support for l3_noc for the upcoming 3.16 window. This series was posted
>    http://marc.info/?l=linux-omap&m=139750288003978&w=2 and the
>    functionality enabled by the first pull request for driver.
> 
> The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:
> 
>   Linux 3.14 (2014-03-30 20:40:15 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/nmenon/linux-2.6-playground.git pull/l3noc/dts-fixes
> 
> for you to fetch changes up to 2eeddb8a5356e088021a8dd84de870de89bf793d:
> 
>   ARM: dts: AM4372: add l3-noc information (2014-05-05 14:35:29 -0500)

Thanks pulling into omap-for-v3.16/fixes-not-urgent.

Tony
 
> ----------------------------------------------------------------
> Afzal Mohammed (1):
>       ARM: dts: AM4372: add l3-noc information
> 
> Rajendra Nayak (1):
>       ARM: dts: DRA7: Use dra7-l3-noc instead of omap4-l3-noc
> 
>  arch/arm/boot/dts/am4372.dtsi |    6 +++++-
>  arch/arm/boot/dts/dra7.dtsi   |    6 +++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> -- 
> Regards,
> Nishanth Menon
> 
