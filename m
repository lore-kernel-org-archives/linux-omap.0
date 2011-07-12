From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] OMAP4: Keyboard: Mux changes in the board file
Date: Tue, 12 Jul 2011 12:03:17 +0530
Message-ID: <4E1BEAAD.4090606@ti.com>
References: <1308831317-17092-1-git-send-email-shubhrajyoti@ti.com>	 <20110701074824.GH23145@atomide.com> <1310414883.3077.101.camel@vence>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34502 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753702Ab1GLGs3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 02:48:29 -0400
Received: by yih10 with SMTP id 10so2577392yih.15
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 23:40:07 -0700 (PDT)
In-Reply-To: <1310414883.3077.101.camel@vence>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tuesday 12 July 2011 01:38 AM, Kevin Hilman wrote:
> On Fri, 2011-07-01 at 00:48 -0700, Tony Lindgren wrote:
>> * Shubhrajyoti D<shubhrajyoti@ti.com>  [110623 05:10]:
>>> The mux settings for keypad  are done for omap4430sdp in
>>> board file.
>> Applying into devel-board branch.
>>
>>> +static struct omap_board_data keypad_data = {
>>> +	.id	    = 1,
>>> +	.pads	 = keypad_pads,
>>> +	.pads_cnt       = ARRAY_SIZE(keypad_pads),
>>> +};
>> Aligned this struct better.
> This patch (and this struct) introduces another section mismatch warning
> because it references another struct which is __initdata but the struct
> itself is not:
>
> WARNING: vmlinux.o(.data+0x37788): Section mismatch in reference from
> the variable keypad_data to the (unknown reference) .init.data:(unknown)
> The variable keypad_data references
> the (unknown reference) __initdata (unknown)
>
> A quick glance suggests the the right fix is that this struct should
> also be __initdata:
Yes , will incorporate the comments and send a patch.
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> b/arch/arm/mach-omap2/board-4430sdp.c
> index c7cef44..66758bf 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -199,7 +199,7 @@ static struct omap4_keypad_platform_data
> sdp4430_keypad_data = {
>   	.cols			= 8,
>   };
>
> -static struct omap_board_data keypad_data = {
> +static struct omap_board_data keypad_data __initdata = {
>   	.id	    		= 1,
>   	.pads	 		= keypad_pads,
>   	.pads_cnt       	= ARRAY_SIZE(keypad_pads),
>
>

