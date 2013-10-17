From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] OMAP4460: cpuidle: Workaround for ROM bug because
 of CA9 r2pX GIC control register change
Date: Thu, 17 Oct 2013 12:28:35 +0300
Message-ID: <525FADC3.4090505@ti.com>
References: <1382000776-15897-1-git-send-email-grygorii.strashko@ti.com>
 <525FACA9.3060405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <525FACA9.3060405@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Taras Kondratiuk <taras.kondratiuk@linaro.org>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, open list <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Sorry, forgot to mention that patches are based on 4a10c2a Linux 3.12-rc2

On 10/17/2013 12:23 PM, Grygorii Strashko wrote:
> The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
> "ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change."
> need to be applied not only when system is booting, but when
> MPU hits OSWR state through CPUIdle too.
>
> Now the same issue is reproduced on boards PandaES and Tablet/Blaze with
> SOM OMAP4460 ES1.0 when CONFIG_CPU_IDLE is enabled.
> - GIC distributor is disabled
> - scheduling is not performed any more
>
> Grygorii Strashko (2):
>    Revert "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"
>    ARM: OMAP4460: cpuidle: WA for ROM bug because of CA9 r2pX gic control register change
>
>   arch/arm/mach-omap2/common.h              |    6 +++++
>   arch/arm/mach-omap2/cpuidle44xx.c         |   35 +++++++++++++++++++++++++++--
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c |   14 ++++++++++++
>   arch/arm/mach-omap2/omap4-common.c        |    6 +++++
>   4 files changed, 59 insertions(+), 2 deletions(-)
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
>
> Regards,
> -grygorii
>
