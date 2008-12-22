From: "Kainan Cha" <thezha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C1 controller timed out issue
Date: Mon, 22 Dec 2008 10:07:50 -0600
Message-ID: <c236f0530812220807h4f0d92a4v51001e0283dd279a@mail.gmail.com>
References: <f502236f0812200204h1ef1df01sf79243e6e276074d@mail.gmail.com>
	 <20081220131321.GB10866@frodo>
	 <c236f0530812200935y1397d03bm54fe7f3714776b0@mail.gmail.com>
	 <20081222160302.GC17843@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081222160302.GC17843@frodo>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: pramod gurav <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Thanks.

Kainan

On Mon, Dec 22, 2008 at 10:03 AM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote:
> On Sat, Dec 20, 2008 at 11:35:51AM -0600, Kainan Cha wrote:
>> Balbi,
>>
>> I have also seen this issue once in a while but I am using 2.6.24 kernel. Do
>> you know which commits in the linux-omap git fixes this issue so I can
>> backport?
>
> Hmm, I suppose it's this one:
>
> commit 663715fc55ea5d292171c6934a2b91d8f4874171
> Author: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Date:   Fri Oct 10 10:58:30 2008 -0600
>
>    i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
>
>    omap_i2c_unidle() and omap_i2c_idle() are called recursively during
>    omap_i2c_probe().  This is evidently unexpected and will wipe
>    out the I2C interrupt enable register the second time that
>    omap_i2c_idle() is called consecutively.  Any I2C transactions
>    following a probe of a bus with at least one device on it will then
>    time out.
>
>    Fix by moving omap_i2c_idle() further up in omap_i2c_probe().  Ensure
>    the I2C controller is marked as idle before the probe starts.  Also
>    attempt to catch future reappearances of this bug early in development
>    by warning in omap_i2c_{un,}idle() when they are called recursively.
>
>    Problem reported by David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>.
>
>    Tested on 3430SDP and 2430SDP.
>
> But I'd say the changes to twl4030-core.c also helped and those will be
> nasty to backport :-p
>
> --
> balbi
>
