From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
Date: Mon, 24 Sep 2012 14:13:46 +0530
Message-ID: <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
	<1346943430-18236-3-git-send-email-kishon@ti.com>
	<CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:49939 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab2IXInx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 04:43:53 -0400
Received: by vcbfo13 with SMTP id fo13so5999544vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 01:43:46 -0700 (PDT)
In-Reply-To: <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: b-cousson@ti.com, tony@atomide.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

Hi,

On Sat, Sep 22, 2012 at 3:03 AM, Rabin Vincent <rabin@rab.in> wrote:
> 2012/9/6 Kishon Vijay Abraham I <kishon@ti.com>:
>> All the PHY configuration other than VBUS, ID GND and OTG SRP are removed
>> from twl6030. The phy configurations are taken care by the dedicated
>> usb2 phy driver. So twl6030 is made as comparator driver for VBUS and
>> ID detection.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> USB doesn't work on pandaboard on linux-next, and bisection shows this
> patch.  Unfortunately, I can't provide a dmesg log because USB is the
> only way I currently have to get one out(!), but presumably it's because
> this omap-usb2 device is never registered?  Looks like this breaks
> non-dt USB on pandaboard; is that intended?

Yes. omap-usb2 is *only* dt supported (New drivers shouldn't have the
old non-dt support).
Some patches are queued only for 3.7.

In case you want to use MUSB please use these patches on linux-next..
[PATCH v2] arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp
[PATCH] ARM: OMAP2+: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs
entries (from Benoit)
[PATCH 0/2] ARM: dts: Add subnode for ocp2scp (patch series)
[PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB (patch series)

Pls note all these patches are queued for 3.7

Thanks
Kishon
