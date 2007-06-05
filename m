From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Disable old OMAP RTC driver if RTC_DRV_OMAP is enabled
Date: Tue, 5 Jun 2007 03:32:52 -0700
Message-ID: <20070605103252.GG859@atomide.com>
References: <fb249edb0706040718g14b6fc80r7d3c28204dbe53e8@mail.gmail.com>
	<fb249edb0706040720t13ff9bfan8c31b2083959f7a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0706040720t13ff9bfan8c31b2083959f7a3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [070604 07:25]:
> This time with the actual change.
>
> On 04/06/07, andrzej zaborowski <balrogg@gmail.com> wrote:
>> Make the old RTC driver depend on !RTC_DRV_OMAP to avoid conflicts. It
>> makes the new driver in rtc class take precedence over the old one.
>>
>> What's the status of the OMAP RTC in Character Devices?  Is it going
>> to be removed? Enabling both drivers results in an Oops on boot due to
>> name collision.

Yeah, let's get rid of it. Do you have a patch for that?

>> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

> From 98d5a946f93a4ead2acbce23f1ee2cdb80c24c96 Mon Sep 17 00:00:00 2001
> From: Andrzej Zaborowski <balrog@zabor.org>
> Date: Mon, 4 Jun 2007 17:11:06 +0200
> Subject: [PATCH] Disable old OMAP RTC driver if DRV_RTC_OMAP is enabled.
> 
> ---
>  drivers/char/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 8dd3475..d3ebf75 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -843,7 +843,7 @@ config EFI_RTC
>  	depends on IA64
>  config OMAP_RTC
>  	bool "TI OMAP Real Time Clock"
> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730
> +	depends on !RTC_DRV_OMAP && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730)
>  	help
>  	  Support for TI OMAP RTC
>  
> -- 
> 1.4.4.3
> 

Pushing this today.

Tony
