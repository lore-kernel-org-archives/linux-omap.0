From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/11] Adding OMAP3430 support to plat-omap
Date: Tue, 29 May 2007 09:51:51 -0700
Message-ID: <20070529165151.GB26322@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E33@dlee13.ent.ti.com>
	<fb249edb0705290313h1a570dabqe92f8665cb5e10ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0705290313h1a570dabqe92f8665cb5e10ac@mail.gmail.com>
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

* andrzej zaborowski <balrogg@gmail.com> [070529 03:14]:
>> @@ -279,7 +279,7 @@ int __init omap_sram_init(void)
>>         omap_detect_sram();
>>         omap_map_sram();
>>
>> -       if (!cpu_is_omap24xx())
>> +       if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
>>                 omap1_sram_init();
>>         else
>>                 omap2_sram_init();
>
> Maybe omap cpu_class_is_omap2() would be more apropriate in places like 
> this?

I agree, that cuts down the if this and that clutter.

Tony
