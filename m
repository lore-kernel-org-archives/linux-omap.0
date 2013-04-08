From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/3] ARM: OMAP2+: Export SoC information to
 userspace using SoC infrastructure
Date: Mon, 8 Apr 2013 16:27:19 -0700
Message-ID: <20130408232718.GE10155@atomide.com>
References: <1360842924-32429-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1360842924-32429-1-git-send-email-ruslan.bilovol@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130214 03:59]:
> Hi,
> 
> This patch series is an attempt to export some OMAP SoC
> information (like name, revision etc.) to userspace.
> The first patch does some unification of OMAP SoC
> information representation in current sources.
> Second patch adds exactly needed changes using
> exists in Linux kernel SoC infrastructure.

Thanks for your patience with these patches,
applying into omap-for-v3.10/soc.

Tony
 
> -----------------------------------------
> v4:
> - Moved common part of late init into common function  in additional
>   separate patch
> - rebased on top of 'omap-for-v3.9/soc' branch of tmlind/linux-omap tree
> 
> -----------------------------------------
> v3:
> - reduced number of lines changed in the first patch (reusing
>   existent code)
> 
> -----------------------------------------
> v2:
> - changed cpu_* -> soc_* variable names
> - rebased on top of 'omap-for-v3.9/soc' branch of tmlind/linux-omap tree
> 
> 
> Ruslan Bilovol (3):
>   ARM: OMAP2+: Move common part of late init into common function
>   ARM: OMAP2+: SoC name and revision unification
>   ARM: OMAP2+: Export SoC information to userspace
> 
>  arch/arm/mach-omap2/common.h |    8 ++++
>  arch/arm/mach-omap2/id.c     |   95 ++++++++++++++++++++++++++++++++++++++----
>  arch/arm/mach-omap2/io.c     |   34 +++++++--------
>  arch/arm/plat-omap/Kconfig   |    1 +
>  4 files changed, 112 insertions(+), 26 deletions(-)
> 
> -- 
> 1.7.9.5
> 
