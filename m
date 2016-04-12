From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for dra72-evm rev C (ES2.0)
Date: Tue, 12 Apr 2016 14:13:23 -0700
Message-ID: <20160412211322.GE5995@atomide.com>
References: <1458859969-14298-1-git-send-email-nm@ti.com>
 <1458859969-14298-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458859969-14298-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160324 15:53]:
> DRA72-EVM now has an upgrade to Rev C with ES2.0 silicon. As part of
> this change, a few updates were factored in that were software
> incompatible with previous board in few areas:
> - We now use DP83867 ethernet phy instead of older DP838865 which fails
>   in certain usecases.
> - Two ethernet ports now instead of the single one in rev B.
> - polarities changed for certain pcf gpios
> - Due to SoC phy current requirements, VDDA supplies are split between
>  ldo5 and ldo2 (ldo2 was previously unused). NOTE: DSS (VDDA_VIDEO) is
>  still supplied by ldo5.
> 
> NOTE: It does not make much sense to spin off a new board compatible
> flag since there is no real benefit for the same.

I guess that can always be added later on if needed.

Can you please repost this against current omap-for-v4.7/dt as it
no longer applies?

Thanks,

Tony
