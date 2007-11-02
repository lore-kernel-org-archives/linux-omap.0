From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATC 2/3]  silicon revision check for OMAP2/3
Date: Fri, 2 Nov 2007 17:57:06 +0200
Message-ID: <20071102155706.GA24982@intune.research.nokia.com>
References: <00f201c81d5e$c4aaac30$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <00f201c81d5e$c4aaac30$6a8918ac@ent.ti.com>
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

Hi,

On Fri, Nov 02, 2007 at 08:13:44PM +0530, ext Girish wrote:
>  # undef cpu_is_omap3430
> -# define cpu_is_omap3430()		is_omap3430()
> +#define cpu_is_omap3430()		is_omap3430()

Why the inconsistency?

> +#define is_device_type_test() \
> +		(((system_rev & 0x700) >> 8) == DEVICE_TYPE_TEST)
> + [...]
> +#define get_device_type() \
> +		((system_rev & 0x700) >> 8)

Nice work on defining the get_device_type() macro, but why not use it
above, so you have:
#define is_device_type_test() (get_device_type == DEVICE_TYPE_TEST)

Cheers,
Daniel
