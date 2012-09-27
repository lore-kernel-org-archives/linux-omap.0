From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 15:41:41 -0500
Message-ID: <CAOCHtYjjczpQ0oJ4zgrExdF7C-OAsfzMLwAEfdExkFG2uiUKgw@mail.gmail.com>
References: <50648AA2.2010004@johnea.net>
	<CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
	<5064A173.5000909@johnea.net>
	<CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com>
	<CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com>
	<5064B41D.9030709@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39836 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2I0Ull (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 16:41:41 -0400
Received: by vcbfo13 with SMTP id fo13so2549946vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 13:41:41 -0700 (PDT)
In-Reply-To: <5064B41D.9030709@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@johnea.net
Cc: linux-omap@vger.kernel.org

On Thu, Sep 27, 2012 at 3:16 PM,  <linux@johnea.net> wrote:
> On 09/27/2012 12:39 PM, Robert Nelson wrote:
>
>>>
>>> So, i would first look at the config (zcat /proc/config.gz) between
>>> those two releases, and if the arch developers added any more patches
>>> to it..
>>
>>
>>
>> https://github.com/archlinuxarm/PKGBUILDs/commit/68a9e5a1609fde10a2f31dac8df211f0c3874eb7
>>
>> It looks like they disabled CONFIG_OMAP_RESET_CLOCKS
>>
>> I'm pretty sure that would force you to be stuck with what ever u-boot
>> sets up for those pins...
>
>
> Thank you very much Robert!
>
> I found this in your 3.5 series patchset logs:
>
> "beagle: video works now, had to drop the hi-speed pll divider, as the
> infastructure for it looks to have been removed"
>
> https://github.com/RobertCNelson/stable-kernel/commit/e7c8d9e8894997ae6a1ad9c83292ed75c5ac32c5
>
> Which makes me think 3.5.4 on the beagle with your patches will have DVI
> again.

Correct, dropping that specific patch (1), got 3.5.x working on my
beagle again. .( i was distracted with an another project, so i was a
little late in testing/stabilizing 3.5.x when porting the v3.4.x
patchset ;) ..)

But at the same time, that was using a nice feature (hi speed pll:
.dispc_fclk_src = OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,) to get a
higher pixel clock's on 3.2/3.4 to easier support displays that needed
an exact pixel clock. However since we didn't push that mainline and
no other board actually used that in mainline, it was wiped on a
cleanup (2). ;)

1: https://github.com/RobertCNelson/stable-kernel/blob/v3.5.x/patches/beagle/0001-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch
2: http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=commit;h=b6e695abe710ee1ae248463d325169efac487e17

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
