From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: first set of hwmod changes for v4.7
Date: Fri, 22 Apr 2016 15:17:35 -0700
Message-ID: <20160422221734.GL5995@atomide.com>
References: <alpine.DEB.2.02.1604170005480.13961@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1604170005480.13961@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [160416 17:07]:
> Hi Tony
> 
> The following changes since commit 1cbabcb9807e31e87ef3a12af76ea025ceb582d3:
> 
>   ARM: DRA7: clockdomain: Implement timer workaround for errata i874 (2016-04-10 11:43:57 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.7/omap-hwmod-a
> 
> for you to fetch changes up to c20c8f750d9f8f8617f07ee2352d3ff560e66bc2:
> 
>   ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check sequence (2016-04-10 13:20:11 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: first set of hwmod changes for v4.7
> 
> For the DRA7xx platform, add IP block data for the McASP, PWMSS,
> and GPTimer12 IP blocks.  Add lock and unlock functions for the
> RTC IP blocks on the DRA7xx, AM33xx, and AM43xx devices.  And add
> a fix for the hwmod core for device driver unbind operations for
> IP blocks with hardreset lines.

Thanks pullling into omap-for-v4.7/soc.

Tony
