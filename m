From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] omap fixes for v4.6-rc cycle
Date: Fri, 22 Apr 2016 17:21:51 -0700
Message-ID: <7hmvoltbs0.fsf@baylibre.com>
References: <20160414203619.GR5973@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160414203619.GR5973@atomide.com> (Tony Lindgren's message of
 "Thu, 14 Apr 2016 13:36:19 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 19e831b272e6db5884be085be66e44da975c73a9:
>
>   Merge branch 'fixes-rc2' into omap-for-v4.6/fixes (2016-04-08 09:18:00 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc3
>
> for you to fetch changes up to 1560d15861769c23fd981e2d60dc7fd790b21e1e:
>
>   ARM: OMAP3: Fix external abort on 36xx waking from off mode idle (2016-04-14 08:27:30 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps for v4.6-rc cycle:
>
> - Clockdomain fix for dra7 timer interrupts
>
> - Two fixes for GPMC EDMA binding, I missed the need for a merge with
>   GPMC changes and EDMA changes
>
> - Fix beagle-x15 eSATA by dropping misconfigured extcon_usb1
>
> - Fix occasional external aborts on 36xx with PM that we've been
>   chasing for past few months. It turned out to be duplicate restore
>   of INTC registers that can in some cases cause us to hit erratum 1.106.
>
> ----------------------------------------------------------------

Pulled into fixes,

Thanks,

Kevin
