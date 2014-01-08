From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] driver-core: platform: Resolve DT interrupt references
 late
Date: Wed, 08 Jan 2014 14:41:19 +0100
Message-ID: <4589157.TquA4Q59fC@wuerfel>
References: <20140108011957.GK5074@atomide.com>
 <1389185477-507-1-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389185477-507-1-git-send-email-treding@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 08 January 2014 13:51:17 Thierry Reding wrote:
> When devices are probed from the device tree, any interrupts that they
> reference are resolved at device creation time. This causes problems if
> the interrupt provider hasn't been registered yet at that time, which
> results in the interrupt being set to 0.

Thanks for looking at this problem, it has bothered a lot of people
for a long time. I'm sorry I wasn't there for the discussion in November,
but when it came up before, I suggested a different solution that
apparently didn't get implemented.

> Note that this patch is the easy way out to fix a large part of the
> problems for now. A more proper solution for the long term would be to
> transition drivers to an API that always resolves resources of any kind
> (not only interrupts) at probe time.
> 
> For some background and discussion on possible solutions, see:
> 
> 	https://lkml.org/lkml/2013/11/22/520

I hope I read this thread correctly, sorry if I missed an important
part. My idea was to add the code not in platform_get_irq() but add
the resource in platform_drv_probe(), and just bail out with
-EPROBE_DEFER there if necessary.

We could then skip adding the resources at device creation time.
Is this something you already plan to do later, or is there a reason
it wouldn't work?

In the meantime, I don't see anything with your patch, but it also
wouldn't hurt to do it now if it solves all the problems.

	Arnd
