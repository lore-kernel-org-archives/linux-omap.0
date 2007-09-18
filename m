From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [RFC] [PATCH 0/14] Update OMAP defconfigs
Date: Tue, 18 Sep 2007 13:00:11 -0400
Message-ID: <31e679430709181000j2637cd18y83f0efc24bdbcabe@mail.gmail.com>
References: <11900606011267-git-send-email-felipe.lima@indt.org.br>
	<46EFFC4D.7010402@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46EFFC4D.7010402@googlemail.com>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Dirk,

On 9/18/07, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Felipe Balbi wrote:
> > The following patch series updates the defconfigs for OMAP boards.
>
> Do these updates include functional changes? Or are they only
> non-function-change updates to 2.6.23-rc6-omap1?
>
> E.g. in omap_2430sdp_defconfig there is
>
> -# CONFIG_SYSCTL_SYSCALL is not set
> +CONFIG_SYSCTL_SYSCALL=y
>
> +CONFIG_OMAP_DEBUG_DEVICES=y
>
> -# CONFIG_MACH_OMAP_H4 is not set
> +CONFIG_MACH_OMAP_H4=y
>
> -CONFIG_MACH_OMAP_2430SDP=y
> +# CONFIG_MACH_OMAP_2430SDP is not set
>
> -CONFIG_PREEMPT=y
> +# CONFIG_PREEMPT is not set
>
> -CONFIG_PM=y
> +# CONFIG_PM is not set
>
> -# CONFIG_IRDA is not set
> +CONFIG_IRDA=y

I just noticed that make oldconfig is not behaving right.
If you look a bit closer, you'll that it changed all the ARCH_OMAP* to OMAP2

I'm rebuilding this same series with make menuconfig.

After that I'll repost it... :-)

Thanks Dirk

>
> ...
>
> Regards
>
> Dirk
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
