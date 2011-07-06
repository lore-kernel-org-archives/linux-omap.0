From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Wed, 06 Jul 2011 07:30:48 -0700
Message-ID: <87ei23jxbb.fsf@ti.com>
References: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>
	<8739ikp9aa.fsf@ti.com>
	<CAOMWX4crxR0TQ38mFVkqv5eDQuEAry139+zoD2kKNm6imeR7yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMWX4crxR0TQ38mFVkqv5eDQuEAry139+zoD2kKNm6imeR7yQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Nishanth Menon's message of "Tue, 5 Jul 2011 17:05:48 -0700")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org> writes:

> On Tue, Jul 5, 2011 at 17:01, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>>
>> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>>
>> > Currently the fifo depth is set to zero for OMAP4 which disables
>> > the FIFO usage. This patch enables the FIFO usage for I2C transactions
>> > on OMAP4 also.
>> >
>> > Tested on omap4430 and 3430.
>> >
>> > Reported-By: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> > ---
>> > Rebased on top of the series by Andy Green
>> > http://www.spinics.net/lists/linux-i2c/msg05632.html
>>
>> Thanks.
>>
>> This is v3.1 material, but would be nice to see a couple tested-by or
>> acked-by tags from folks that are more actively using the I2C driver
>> before merging
>
> For what it is worth: tested on SDP4460/4430 with 255 multi-byte i2c
> read operation on twl6030.
>
> Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>

Thanks Nishanth,

Kevin
