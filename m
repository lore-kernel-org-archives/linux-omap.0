From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: 3.12: omap4: cpuidle: solid hangs at boot
Date: Fri, 15 Nov 2013 14:41:00 +0530
Message-ID: <5285E524.50202@ti.com>
References: <20131114110445.GB4594@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757190Ab3KOJLG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Nov 2013 04:11:06 -0500
In-Reply-To: <20131114110445.GB4594@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>

+ Kevin

Hi Paolo,

On Thursday 14 November 2013 04:34 PM, Paolo Pisati wrote:
> Vanilla 3.12 multi_v7_defconfig + cpu_idle result in a solid hang on my pandaes
> board: has anyone experienced it before? is cpu_idle safe on omap4?
I have also seen the same issue on my panda es board.
On further investigation, it seemed to work on 3.11 and broken between 3.12-rc1 and 3.12-rc2
because of the following patch: 
7835027 ARM: OMAP4: cpuidle: fix: call cpu_cluster_pm_exit conditionally
(http://www.mail-archive.com/linux-omap@vger.kernel.org/msg94655.html)

But by applying a recent patch from Grygorii Strashko https://patchwork.kernel.org/patch/3084521/ 
seems to make it work.
You can give a try by applying the given patch.

Kevin, please correct me if I am wrong.

Thanks and regards,
Lokesh
> 
> same kernel boots fine on omap3 and some other arm boards fwiw.
> if you want to reproduce it:
> 
> config: http://people.canonical.com/~ppisati/3.12_armv7multi_cpuidle/config
> 
> zImage: http://people.canonical.com/~ppisati/3.12_armv7multi_cpuidle/zImage
> 
> boot log: http://paste.ubuntu.com/6415293/
> 

