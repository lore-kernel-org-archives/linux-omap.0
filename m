From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch twl] twl4030-core -- more cleanups
Date: Fri, 3 Oct 2008 01:15:53 -0700
Message-ID: <200810030115.54197.david-b@pacbell.net>
References: <200810021221.20286.david-b@pacbell.net> <EAF47CD23C76F840A9E7FCE10091EFAB028C5400D3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:42544 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751401AbYJCIP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 04:15:56 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C5400D3@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 02 October 2008, Pakaravoor, Jagadeesh wrote:
> >  /*
> > - * twl4030_irq_thread() runs as a kernel thread.  It queries the twl4030
> > - * interrupt controller to see which modules are generating interrupt requests
> > - * and then calls the desc->handle method for each module requesting service.
> > + * This thread processes interrupts reported by the Primary Interrupt Handler.
> >   */
> 
> Why do we need to remove that piece of comment?
> 
> Can we not keep the comment this way?

We "can", but "should" we?

The general policy on comments is that they should not
be translating the C code into English.  Not only are
such comments pointless (the C code says the same thing,
more precisely) but they also are more likely to become
obsolete as the code changes.  (That's a well known
problem:  comments usually don't get updated when the
code changes.)

So in my opinion we "should" not have this comment
just paraphrase (in English) what the code does,
one sentence per code block.

>   /*
>  - * twl4030_irq_thread() runs as a kernel thread.  It queries the twl4030
>  - * interrupt controller to see which modules are generating interrupt requests
>  + * This thread processes interrupts reported by the Primary Interrupt Handler,
>    * and then calls the desc->handle method for each module requesting service.

Plus, it's desc->handle_irq() not desc->handle().  ;)


I expect all the details of the IRQ handling to get overhauled
in a while, anyway.  Mainline will be getting some threaded
IRQ infrastructure, and I'd expect it to help out here.

(And then there's the way every SIH handler seems to
be getting its own irq_chip and handler thread.  I'm
sure that can be done much better.)

- Dave



> >   */
> 
> --
> Jagadeesh
> 
> 


