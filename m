From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH] OMAP: 2430SDP: Support LCD display as a FB device
Date: Sat, 26 May 2007 03:04:48 +0400
Message-ID: <46576B90.2050508@gmail.com>
References: <200705251518.13137.hyau@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200705251518.13137.hyau@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hunyue Yau <hyau@mvista.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hunyue Yau wrote:
>
> +#define TWL4030_VAUX2_DEV_GRP           0x1B 
> +#define TWL4030_VAUX2_DEDICATED         0x1E
> +#define TWL4030_MODULE_PM_RECIEVER  0x13
> +
> +
> +

What's the reason to re-define this?
It's already defined in asm/arch/twl4030.h.


Thanks,
Dmitry
