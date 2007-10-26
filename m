From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 2/2] silicon revision check for OMAP2/3
Date: Fri, 26 Oct 2007 20:52:24 +0300
Message-ID: <20071026175224.GA5457@intune.research.nokia.com>
References: <000d01c817e2$90dd0230$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <000d01c817e2$90dd0230$6a8918ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Girish <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 26, 2007 at 08:42:03PM +0530, ext Girish wrote:
> +#define is_sil_rev_greater_than(rev) \
> +		(((((system_rev & 0xffff0000) >> 16) == \
> +		((rev & 0xffff0000) >> 16)) && 	\
> +		(system_rev & 0xf000) >> 12) > ((rev & 0xf000) >> 12))
> +#define is_sil_rev_less_than(rev) \
> +		(((((system_rev & 0xffff0000) >> 16) == \
> +		((rev & 0xffff0000) >> 16)) && 	\
> +		(system_rev & 0xf000) >> 12) < ((rev & 0xf000) >> 12))
> +#define is_sil_rev_equal_to(rev) \
> +		(((((system_rev & 0xffff0000) >> 16) ==	\
> +		((rev & 0xffff0000) >> 16)) && \
> +		(system_rev & 0xf000) >> 12) == ((rev & 0xf000) >> 12))
> +#define get_sil_rev() \
> +		((system_rev & 0xf000) >> 12)

Hi,
Just for code clarity, you could use (taking is_sil_rev_greater_than as
an example):
#define is_sil_rev_greater_than(rev) \
                ((system_rev & 0xffff0000) == (rev & 0xffff0000) && \
                 (system_rev & 0x0000f000) == (rev & 0x0000f000))

You don't need the extra shifts in the comparison.  But, even better,
you could use:
#define get_sil_generation(rev) ((rev & 0xffff0000) >> 16)
#define get_sil_revision(rev) ((rev & 0x00000f000) >> 12)
#define is_sil_rev_greater_than(rev) \
                ((get_sil_generation(system_rev) == \
                  get_sil_generation(rev)) && \
                 (get_sil_revision(system_rev) >
                  get_sil_revision(rev)))

and likewise for all the rest.

Cheers,
Daniel
