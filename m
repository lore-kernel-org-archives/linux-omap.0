From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: don't save a value only needed for read-clearing
Date: Thu, 15 Nov 2012 15:34:10 +0530
Message-ID: <CAM=Q2cuRBK4SG9HfcV+L7Yfwv4kv8rTOXzrnUbjfE+-c7JNoNA@mail.gmail.com>
References: <1352913666-11022-1-git-send-email-wolfram@the-dreams.de>
	<20121114183739.GA30212@arwen.pp.htv.fi>
	<20121114185033.GB26955@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121114185033.GB26955-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 15, 2012 at 12:20 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
>> > This makes one of my code analyzers happy and makes me a part of the
>>
>> anything open source which we could all be using ? :-)
>
> 'my' as in 'one of those I am using'. It was cppcheck which found that
> flaw. Its use for kernel code is limited, but it does find one or the
> other thing.

sparse did not complain though.
So it seems it helps to run multiple static tools:-)

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
