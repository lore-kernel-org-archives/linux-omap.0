From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v4 00/21] ARM: OMAP2+: Adapt to ehci-omap changes for
 3.10
Date: Fri, 5 Apr 2013 11:56:01 +0200
Message-ID: <515E9FB1.2040803@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com> <515E8B99.8080803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <515E8B99.8080803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 04/05/2013 10:30 AM, Benoit Cousson wrote:

...

>>   ARM: dts: OMAP4: Add HS USB Host IP nodes
>>   ARM: dts: OMAP3: Add HS USB Host IP nodes
>>   ARM: dts: omap3-beagle: Add USB Host support
> 
> These 3 DTS patches are good to me, but I cannot applied them on top of
> the already existing patches I queued for 3.10.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> for_3.10/dts
> 
> Could you rebase these 3 ones only, and I will applied them.

Mmm, in fact, I've just seen the pull request from Tony :-(


Tony,

Don't you want to remove these DTS patches from the pull-request?

Otherwise, I will have to rebase the whole DTS series on top of yours.
That being said, if the branch is not supposed to be rebased, it is doable.

Thanks,
Benoit
