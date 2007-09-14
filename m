From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 1/2] [OMAP MMU FWK] Translate printk to dev_* and break
 lines with more than 80 char
Date: Fri, 14 Sep 2007 18:38:31 +0200
Message-ID: <46EAB907.5000407@googlemail.com>
References: <11897112792637-git-send-email-edubezval@gmail.com>
	<11897112792849-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11897112792849-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch:
> 
> - Translates printk to dev_*
> - Breaks lines with more than 80 columns
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  arch/arm/mach-omap1/mmu.c       |   10 ++--
>  arch/arm/mach-omap2/mmu.c       |   29 ++++++----
>  arch/arm/plat-omap/mmu.c        |  107 +++++++++++++++++++--------------------
>  include/asm-arm/arch-omap/mmu.h |   15 ++++--
>  4 files changed, 85 insertions(+), 76 deletions(-)

Is this an update of

http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011180.html

?

So above patch is outdated?

Just for my patch tracking ;)

Regards

Dirk
