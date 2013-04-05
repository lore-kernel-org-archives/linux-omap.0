From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 00/21] ARM: OMAP2+: Adapt to ehci-omap changes for 3.10
Date: Fri, 5 Apr 2013 08:43:00 -0700
Message-ID: <20130405154259.GZ10155@atomide.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
 <515E8B99.8080803@ti.com> <515E9FB1.2040803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <515E9FB1.2040803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Benoit Cousson <b-cousson@ti.com> [130405 03:00]:
> On 04/05/2013 10:30 AM, Benoit Cousson wrote:
> 
> ...
> 
> >>   ARM: dts: OMAP4: Add HS USB Host IP nodes
> >>   ARM: dts: OMAP3: Add HS USB Host IP nodes
> >>   ARM: dts: omap3-beagle: Add USB Host support
> > 
> > These 3 DTS patches are good to me, but I cannot applied them on top of
> > the already existing patches I queued for 3.10.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> > for_3.10/dts
> > 
> > Could you rebase these 3 ones only, and I will applied them.
> 
> Mmm, in fact, I've just seen the pull request from Tony :-(
> 
> 
> Tony,
> 
> Don't you want to remove these DTS patches from the pull-request?

Oops sorry :( Looks like I applied them mistakenly as I saved all
the patches into a mbox, then applied it. Anyways, too late to start
messing with it now.
 
> Otherwise, I will have to rebase the whole DTS series on top of yours.
> That being said, if the branch is not supposed to be rebased, it is doable.

I pulled in your for_3.10/dts for testing, and to me it looks like
it's just overlapping additions. So that should be OK to resolve while
pulling it in.

It seems there's no need to add omap-for-v3.10/usb as a dependency for
your for_3.10/dts unless the conflict gets non-trivial with some
additional patches.

Regards,

Tony
