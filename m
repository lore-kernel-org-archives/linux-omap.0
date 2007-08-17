From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Re: traffic controller priority adjustment
Date: Fri, 17 Aug 2007 21:20:29 +0530
Message-ID: <2d51cbf80708170850v5fd3872fo4c0e619a2c55d62b@mail.gmail.com>
References: <760329.90465.qm@web30615.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <760329.90465.qm@web30615.mail.mud.yahoo.com>
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
To: Zgembo Adislic <adislic_zgembo@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 8/17/07, Zgembo Adislic <adislic_zgembo@yahoo.com> wrote:
> Hello,
>
> I'd like to adjust the priority register for EMIFF arbitration, so that DMA will get priority over other masters (MPU, DSP).  I wonder if there is  an API in kernel for this?
>
> I am using OMAP5910 and linux kernel 2.6.8.1.
>
> Any opinions about this?
>
> Zgembo
>
>
>
> ---------------------------------
> Ready for the edge of your seat? Check out tonight's top picks on Yahoo! TV.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

I am not sure I understood you fully, but you might want to have a
look at  plat-omap/dma.c.

omap_set_dma_priority(int dst_port, int priority) - 2.6.17
omap_set_dma_priority(int lch, int dst_port, int priority) - 2.6.19

No idea about 2.6.8.

-- 

Regards,
Sandeep.
