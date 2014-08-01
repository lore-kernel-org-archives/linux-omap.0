From: Pekon Gupta <pekon.gupta@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc_cs_remap: re-allocating chip-select
 address space based on DT
Date: Fri, 1 Aug 2014 23:38:04 +0530
Message-ID: <CAK1JQxr+YkWF76bFka+24GFScw2y9pQX+O=J=vg6eUHFFCwnoA@mail.gmail.com>
References: <1406139458-11676-1-git-send-email-pekon@ti.com>
	<53DB7349.4000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64140 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaHASIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2014 14:08:06 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so4734871wes.33
        for <linux-omap@vger.kernel.org>; Fri, 01 Aug 2014 11:08:04 -0700 (PDT)
In-Reply-To: <53DB7349.4000105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>

Hi Roger,

On Fri, Aug 1, 2014 at 4:30 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 07/23/2014 09:17 PM, Pekon Gupta wrote:
>> +     /* allocate enough address-space under GPMC chip-select to device */
>> +     if (size > SZ_256M) {
>> +             pr_err("%s: memory device > 256MB not supported\n", __func__);
>> +             return -ENODEV;
>> +     } else if (size > SZ_128M) {
>> +             WARN((size != SZ_256M), "cs=%d: allocating 256MB\n", cs);
>> +             size = SZ_256M;
>> +     } else if (size > SZ_64M) {
>> +             WARN((size != SZ_128M), "cs=%d: allocating 128MB\n", cs);
>> +             size = SZ_128M;
>> +     } else if (size > SZ_32M) {
>> +             WARN((size != SZ_64M), "cs=%d: allocating 64MB\n", cs);
>> +             size = SZ_64M;
>> +     } else if (size > SZ_16M) {
>> +             WARN((size != SZ_32M), "cs=%d: allocating 64MB\n", cs);
>
> Print message should be "allocating 32MB"
>
yes, my bad, copy-paste errors..

[...]

>
> Otherwise it is fine. I can make the changes and resend.
>
> cheers,
> -roger
>
Yes please re-send. Thanks much.


with regards, pekon
