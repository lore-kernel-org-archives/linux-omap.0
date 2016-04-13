From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: DRA7: Updates for power domain data
Date: Wed, 13 Apr 2016 14:30:56 -0700
Message-ID: <20160413213055.GE5995@atomide.com>
References: <1459461515-5192-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459461515-5192-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160331 15:01]:
> First level updates for power domain data, in line with the latest
> AM57xx and DRA7 TRMs.
> 
> NOTE: follow on patches are pending for the following:
> 
> a) wakeupgen is somehow messedup again and mpu pd no
> longer goes to low power mode. I am looking into that.
> http://pastebin.ubuntu.com/15571519/ gets past that story - but I see
> mpu_pwrdm stuck in ON though..
> 
> b) beagleboard-X15 does require the following patch
> https://patchwork.kernel.org/patch/8718431/
> 
> c) We do have yet another major TRM update to only allow ON and OFF
> for all power domains other than core and MPU (MPU still will support
> CSWR) - I am still waiting for TRM update to take place before we can
> actually post upstream.
> 
> BeagleBoard-X15 test log: http://pastebin.ubuntu.com/15571570/

Applying into omap-for-v4.7/soc thanks.

Tony
