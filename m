From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] arm: beaglex15: fix USB Gadget
Date: Wed, 27 Jan 2016 09:01:00 -0800
Message-ID: <20160127170059.GM19432@atomide.com>
References: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: robh+dt@kernel.org, lee.jones@linaro.org, balbi@ti.com, rogerq@ti.com, kishon@ti.com, george.cherian@ti.com, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Chanwoo Choi <cw00.choi@samsung.com> [151229 16:56]:
> This patchset make the extcon-palmas.c more generic style and then send v2
> patchset. I add the Felipe comment of v1 patchset as following:
> But, I have not test on real board because I don't have it.
> Just, I modify this patchset based on v1 patchset[1] from Felipe Balbi.
> 
> - Felipe comment of this patchset:
> "Hi,
> 
> with the following patches I can get USB Gadget working
> with my beagle x15 with today's Linus' tree.
> 
> regards".
> 
> [1] https://lkml.org/lkml/2015/11/12/508
> 
> Changes from v1:
> (https://lkml.org/lkml/2015/11/12/508)
> - Refactoring the extcon-palmas.c driver with more generic style to support
>   the VBUS gpio pin.
> - Use the 'vbus-gpio' property instead of 'interrupts-extended']
> 
> Felipe Balbi (3):
>   extcon: palmas: Add the support for VBUS detection by using GPIO
>   arm: boot: dts: beaglex15: Remove ID GPIO
>   arm: boot: beaglex15: pass correct interrupt

Please feel free to queue these minor dts changes along with the
extcon changes. Usually the subject starts with "ARM: dts:" though.

Anyways for the last two patches in the series:

Acked-by: Tony Lindgren <tony@atomide.com>
