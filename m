From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v3 4/5] dma: cppi41: only allocate descriptor memory once
Date: Tue, 01 Oct 2013 18:22:07 +0200
Message-ID: <524AF6AF.50704@linutronix.de>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com> <1379861404-8250-5-git-send-email-zonque@gmail.com> <20130926082604.GA24205@linutronix.de> <524AC987.5000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524AC987.5000301-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/01/2013 03:09 PM, Daniel Mack wrote:
> Hi Sebastian,

Hi Daniel,

> sorry for the long delay, I got distracted by other things.

No problem.

> Well, I didn't merge the descriptors. Look again at my changes please.
> 
> A simplified version of the code as it stands is:
> 
>   for (i = 0; i < DESCS_AREAS; i++)
>     cdd->cd = dma_alloc_coherent(dev, ..., &cdd->descs_phys, GFP_KERNEL);
> 
>   for (i = 0; i < DESCS_AREAS; i++)
>     dma_free_coherent(dev, mem_decs, cdd->cd, cdd->descs_phys);
> 
> So you're effectively allocating and freeing the same pointer
> DESCS_AREAS times, which is certainly not what you wanted.

Well, no but since DESCS_AREAS is 1 it does not matter.

> 
> And this just doesn't hit you because DESCS_AREAS is always 1:

exactly.

> 
>   BUILD_BUG_ON(DESCS_AREAS != 1);
> 
> 
> So, after all, my patch doesn't really change any of the runtime
> behaviour. Consider it a cosmetic cleanup if you wish :)

But it looks strange (in my opinion at least). But now, that I look
again at it yes you moved the alloc out of the loop and replaced
mem_decs with the computation. So nothing changed but you moved it
outside.

Right I think one desc area should be enough so I would just remove the
for loop and DESCS_AREAS as well. How does this sound to you?

> 
> 
> Thanks,
> Daniel
> 

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
