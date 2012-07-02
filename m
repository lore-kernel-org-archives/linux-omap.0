From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix issues.
Date: Mon, 2 Jul 2012 16:51:26 +0530
Message-ID: <CAP05o4JctmjdAk+S--v9T0PM0kabFN50ESyiPiwAYXNUX5yyBg@mail.gmail.com>
References: <1339691061-12778-1-git-send-email-Russ.Dill@ti.com>
	<20120702112217.GD22065@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:37638 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710Ab2GBLVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 07:21:34 -0400
Received: by lbbgg6 with SMTP id gg6so8854574lbb.8
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 04:21:27 -0700 (PDT)
In-Reply-To: <20120702112217.GD22065@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Partha Basak <parthab@india.ti.com>, Igor Grinberg <grinberg@compulab.co.il>, mantesh@ti.com, s-sapna1@ti.com, Russ Dill <Russ.Dill@gmail.com>

On Mon, Jul 2, 2012 at 4:52 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Russ,
>
> On Thu, Jun 14, 2012 at 09:24:21AM -0700, Russ Dill wrote:
>> From: Russ Dill <Russ.Dill@gmail.com>
>>
>> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixes
>> an issue where the ULPI PHYs were not held in reset while initializing
>> the EHCI controller. However, it also changes behavior in
>> omap-usb-host.c omap_usbhs_init by releasing reset while the
>> configuration in that function was done.
>>
>> This change caused a regression on BB-xM where USB would not function
>> if 'usb start' had been run from u-boot before booting. A change was
>> made to release reset a little bit earlier which fixed the issue on
>> BB-xM and did not cause any regressions on 3430 sdp, the board for
>> which the fix was originally made.
>>
>> This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
>> before adding hcd.', (3aa2ae74) caused a regression on OMAP5.
>>
>> The original fix to hold the EHCI controller in reset during
>> initialization was correct, however it appears that changing
>> omap_usbhs_init to not hold the PHYs in reset during it's
>> configuration was incorrect. This patch first reverts both fixes, and
>> then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
>> reset as the original patch had done. It also is sure to incorporate
>> the _cansleep change that has been made in the meantime.
>>
>> I've tested this on Beagleboard xM, I'd really like to get an ack from
>> the 3430 sdp and OMAP5 guys before getting this merged.
>>
>> v3 - Brown paper bag its too early in the morning actually run
>>      git commit amend fix
>> v2 - Put cansleep gpiolib call outside of spinlock
>>
>> Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
>> ---
>>  drivers/mfd/omap-usb-host.c  |   48 +++++++++++++++++++++++++++++++++++++++++-
>>  drivers/usb/host/ehci-omap.c |   18 +++++++---------
>>  2 files changed, 55 insertions(+), 11 deletions(-)
> I applied this one to my for-linus branch, it will be part of my next 3.5 pull
> request to Linus.
>
> Cheers,
> Samuel.
>

Hi Samuel
       please drop this patch for now , since Alan stern has mentioned
improvements for this patch and we
need to wait for Alan's new patch on ehci-omap.c and then Rus dill
patch and my usbhs tll
patch series need to be rebased.


regards
keshava
