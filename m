From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Basic N800 support
Date: Sat, 27 Jan 2007 08:24:32 +0100
Message-ID: <45BAFE30.5030705@googlemail.com>
References: <20070119205723.GC16754@atomide.com>
	<45B1BEE7.2000603@googlemail.com>
	<20070126213126.GH29286@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070126213126.GH29286@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> Following two patches are still needed to compile and
> mount root.
...
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -767,6 +767,7 @@
...
>  nokia770		MACH_NOKIA770		NOKIA770		755
> +nokia_n800		MACH_NOKIA_N800		NOKIA_N800		5555
>  pnx0106			MACH_PNX0106		PNX0106			756

Any plans to get and use an official number?

But I suppose this would require a N800 bootloader and 
kernel update ;)

Cheers

Dirk
