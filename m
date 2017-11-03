From: Tony Lindgren <tony@atomide.com>
Subject: Re: SDP4430 nightly regression (was: Re: [GIT PULL] two omap
 regression fixes)
Date: Fri, 3 Nov 2017 10:26:48 -0700
Message-ID: <20171103172648.GI28152@atomide.com>
References: <pull-1509652473-291160@atomide.com>
 <20171103104316.GE28231@n2100.armlinux.org.uk>
 <20171103160518.GG28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171103160518.GG28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [171103 16:07]:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [171103 10:45]:
> > In the diffstat between the two build trees (post merge), I don't see
> > anything in arch/arm that could account for it.  I do see some power
> > changes:
> > 
> >  drivers/base/power/domain_governor.c               |  53 +--
> >  drivers/base/power/qos.c                           |   2 +-
> >  drivers/base/power/runtime.c                       |   2 +-
> >  drivers/base/power/sysfs.c                         |  25 +-
> > 
> > but nothing in tty or serial.  These power changes look like QoS
> > changes, which probably aren't related.
> > 
> > Just to make sure, I've diffed the build tree SHAs and the change in
> > Linus' tip, and the two diffs match apart from a couple of SHA blob
> > hashes on a couple of files (EFI stub and MAINTAINERS).
> 
> Initiating git bisect sequence.

Seems this is now fixed in the mainline kernel. I also confirmed
that v4.14-rc6 fails to resume. Most likely Rafael's revert of
the following two commits fixed the issue:

5ba257249e9c ("Revert "PM / QoS: Fix default runtime_pm device resume latency"")
d5919dcc349d ("Revert "PM / QoS: Fix device resume latency PM QoS"")

Regards,

Tony
