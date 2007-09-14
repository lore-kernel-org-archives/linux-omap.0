From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] [OMAP MMU FWK] Translate printk to dev_* and break
	lines with more than 80 char
Date: Fri, 14 Sep 2007 13:18:58 -0400
Message-ID: <a0580c510709141018r7e673cd5r3eb22b7627f4618e@mail.gmail.com>
References: <11897112792637-git-send-email-edubezval@gmail.com>
	<11897112792849-git-send-email-edubezval@gmail.com>
	<46EAB907.5000407@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46EAB907.5000407@googlemail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Dirk,


    Yes, the patch I sent last month is outdated. But this new one has
just little differences. I resent it as the last one was not merged
and the second on the series is on top of this.


Cheers,

On 9/14/07, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >
> > This patch:
> >
> > - Translates printk to dev_*
> > - Breaks lines with more than 80 columns
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> > ---
> >  arch/arm/mach-omap1/mmu.c       |   10 ++--
> >  arch/arm/mach-omap2/mmu.c       |   29 ++++++----
> >  arch/arm/plat-omap/mmu.c        |  107 +++++++++++++++++++--------------------
> >  include/asm-arm/arch-omap/mmu.h |   15 ++++--
> >  4 files changed, 85 insertions(+), 76 deletions(-)
>
> Is this an update of
>
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011180.html
>
> ?
>
> So above patch is outdated?
>
> Just for my patch tracking ;)
>
> Regards
>
> Dirk
>


-- 
Eduardo Bezerra Valentin
