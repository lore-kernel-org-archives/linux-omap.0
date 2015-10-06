From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 6 Oct 2015 13:28:38 +0300
Message-ID: <5613A256.8000105@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com> <20151006083346.GL23801@atomide.com>
 <56139A72.6040600@ti.com> <20151006100000.GN23801@atomide.com>
 <56139CE9.8020002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56139CE9.8020002-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/10/15 13:05, Roger Quadros wrote:
> On 06/10/15 13:00, Tony Lindgren wrote:
>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [151006 02:59]:
>>> On 06/10/15 11:33, Tony Lindgren wrote:
>>>> Does build and boot and use NAND work throughtout the series?
>>>> Otherwise we'll have hard time bisecting anything..
>>>
>>> Yes it does with the following exceptions.
>>>
>>> - Patch 7 "memory: omap-gpmc: Remove NAND IRQ code" breaks prefetch-irq mode
>>> but none of the boards seem to be using it so it shouldn't break NAND on existing boards.
>>> At patch 9 "mtd: nand: omap2: manage NAND interrupts" prefetch-irq mode is working again.
>>> Do you want me to squash patches 7,8,9 so that pre-fetch irq is not broken at any point?
>>
>> OK, no that's fine, no need to squash them together then.
>>
>>> - Then at patch 11 "mtd: nand: omap: Clean up device tree support" we break NAND on all DT
>>> boards as we expect NAND to be a real child node with compatible id. Simply applying the
>>> DT patch at this point makes it work again.
>>
>> Hmm can we at least warn about incompatible DT entry when somebody boots
>> with an older dtb?
> 
> Yes that could be done. It looks like we can use the missing compatible property to identify
> that it is and old DT entry.
> 
> I'll send a v4 of patch 11.

There is another issue. Some of the old DT nodes set the NAND IO address to 0.
As we prevent mapping into first 16MB we see the following message for those nodes. e.g. dra7-evm

[    1.727598] omap-gpmc 50000000.gpmc: cannot remap GPMC CS 0 to 0x00000000
[    1.727605] omap-gpmc 50000000.gpmc: GPMC CS 0 start cannot be lesser than 0x1000000
[    1.727611] omap-gpmc 50000000.gpmc: failed to probe DT children

Hope this is good enough information that DT needs to be updated?

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
