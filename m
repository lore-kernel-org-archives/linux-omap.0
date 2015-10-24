From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod cleanup for v4.4
Date: Fri, 23 Oct 2015 18:14:54 -0700
Message-ID: <20151024011453.GZ3078@atomide.com>
References: <alpine.DEB.2.02.1510231957310.9575@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1510231957310.9575@utopia.booyaka.com>
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

* Paul Walmsley <paul@pwsan.com> [151023 12:58]:
> Hi Tony
> 
> The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> 
>   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.4/omap-hwmod-cleanup-a
> 
> for you to fetch changes up to c4384a97af852121f66e52ba96e98d6f13ad19eb:
> 
>   ARM: OMAP3: hwmod data: Remove legacy mailbox data and addrs (2015-10-23 13:01:25 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: hwmod cleanup for v4.4
> 
> Remove some superfluous data from the OMAP2+ hwmod data files.  Mostly
> this is a result of data being moved to DT files.  Nothing too
> controversial, here.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod-cleanup-a-for-v4.4/20151023130140/

Thanks pulling into omap-for-v4.4/soc. FYI, that's most likely the last branch I'll
do for the upcoming merge window as we're already late with all the regression
fixes. Planning to send it off tomorrow.

Regards,

Tony

> 
> ----------------------------------------------------------------
> Franklin S Cooper Jr (2):
>       ARM: DRA7/AM335x/AM437x: hwmod: Remove elm address space from hwmod data
>       ARM: DRA7/AM335x/AM437x: hwmod: Remove gpmc address space from hwmod data
> 
> Javier Martinez Canillas (1):
>       ARM: OMAP: Remove duplicated operand in OR operation
> 
> Suman Anna (3):
>       ARM: OMAP4: hwmod data: Remove spinlock hwmod addrs
>       ARM: DRA7: hwmod data: Remove spinlock hwmod addrs
>       ARM: OMAP3: hwmod data: Remove legacy mailbox data and addrs
> 
>  .../omap_hwmod_33xx_43xx_interconnect_data.c       | 20 ---------------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 29 ---------------------
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 10 --------
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  3 +--
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 30 ----------------------
>  5 files changed, 1 insertion(+), 91 deletions(-)
