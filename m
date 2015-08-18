From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] omap device tree changes for v4.3, part 4
Date: Tue, 18 Aug 2015 13:34:13 -0700
Message-ID: <20150818203413.GI4732@localhost>
References: <pull-1439455019-336197>
 <55cc7e96.4341440a.f8e59.1a49SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55cc7e96.4341440a.f8e59.1a49SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Thu, Aug 13, 2015 at 03:08:46AM -0700, Tony Lindgren wrote:
> The following changes since commit ed05637c30e6d13e5793aab64d6a6e57e30228af:
> 
>   ARM: dts: omap3-devkit8000: Add ADS7846 Touchscreen support (2015-08-06 02:43:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-pt4-v2
> 
> for you to fetch changes up to 8cbd4c2f6a996f6cf5dfdf8775d331606cff95bd:
> 
>   arm: boot: dts: am4372: add ARM timers and SCU nodes (2015-08-13 01:25:11 -0700)
> 
> ----------------------------------------------------------------
> Fix up bogus RTC compatible change for am4372 and add missing
> DPLL for am4372 cpsw Ethernet driver. Also add ARM global and
> local timers for am4372.
> 

Merged, thanks!


-Olof
