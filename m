From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Wed, 22 Oct 2008 15:23:35 -0700
Message-ID: <a46a26fd0810221523y4a947442p6eb060192603b8f1@mail.gmail.com>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
	 <200810221446.11415.david-b@pacbell.net>
	 <a46a26fd0810221452x1edfead1l524270ddaf250e2a@mail.gmail.com>
	 <200810221502.53045.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.244]:54223 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbYJVWXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 18:23:37 -0400
Received: by ag-out-0708.google.com with SMTP id 31so5039939agc.10
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 15:23:36 -0700 (PDT)
In-Reply-To: <200810221502.53045.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 22, 2008 at 3:02 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 22 October 2008, Juha Kuikka wrote:
>> >> -       __raw_readsl(nand->IO_ADDR_R, buf, len / 2);
>> >> +       __raw_readsl(nand->IO_ADDR_R, buf, len / 4);
>> >>  }
>> >
>> > Shouldn't that have been __raw_readsw() though?
>>
>> Hmh, good point.
>
> Yeah, but the bug was from a patch from me ... sigh.
>
>
>> From the original code it looks like that was the intention but
>> readsl() works just as well.
>
> Really?  Both upper and lower 16-bit units have the right data?

Yes, all data comes in normally. I'm running JFFS2 on top of this.

>> I tested this on OMAP2430 and it works ok.
>>
>> I don't see any mentions in the TRM about the width of the
>> GPMC_NAND_DATA registers but apparently the NAND engine happily
>> accepts 32bit accesses on bus.
>
> Maybe this has to do with the FIFO behavior.  It would certainly
> make sense to allow reads of any size from the FIFO.  If it were
> raw reads on the data bus, then I'd expect that both 8 and 16 bit
> widths would work.  (Assuming NAND chips weren't in parallel...)

Right, for the FIFO in prefetch/writeposting block the TRM explicitly
states that it does accept 8/16/32 bit accesses but I don't see this
driver using the prefetch engine.

No parallel chips here, just a regular 16 bit wide LP NAND.

> If the FIFO is active, and specified to support arbitrary width
> accesses (that don't match the data bus), then by all means use
> the __raw_readsl() call to maximize bandwidth use.

Sure. But interestingly enough even without explicitly using the FIFO
it seems to accept longer bus accesses.

Just to be on the safe side, maybe the patch should indeed be revised
to use __raw_readsw(..., len/2) ?

 - Juha
-- 
Madness takes it's toll. Please have exact change.
