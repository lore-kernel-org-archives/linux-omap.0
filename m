From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 17:18:45 +0530
Message-ID: <CAM=Q2cuK8X8PkAF1=E14WNr4=nH1+h9Zt9u+A=ojSuiFmbgo_Q@mail.gmail.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
	<20120921110050.GC16003@arwen.pp.htv.fi>
	<505C4CA4.6020507@ti.com>
	<20120921113506.GF16003@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120921113506.GF16003@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 5:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Sep 21, 2012 at 04:46:52PM +0530, Shubhrajyoti wrote:
>> On Friday 21 September 2012 04:30 PM, Felipe Balbi wrote:
>> > On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
[...]

>> it it is !  BRK_ERROR_BITS I return.
>
> That's what I mean. rlsi handler is basically taking care of those
> bits... So how come we get RLSI IRQ when those bits aren't set ?
>
> Meaning, you shouldn't ever need that check, right ? Ideally, whenever
> that handler is called, it's because BRK_ERROR_BITS are set.
>
> Maybe add a WARN_ONCE() kinda thing just to see if that will ever really
> happen ??

hmm yes. will get back.

>
> --
> balbi
