From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v3 4/5] dma: cppi41: only allocate descriptor memory
 once
Date: Thu, 26 Sep 2013 10:26:05 +0200
Message-ID: <20130926082604.GA24205@linutronix.de>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com>
 <1379861404-8250-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379861404-8250-5-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Daniel Mack | 2013-09-22 16:50:03 [+0200]:

>cdd->cd and cdd->descs_phys are allocated DESCS_AREAS times from
>init_descs() and freed as often from purge_descs(). This leads to both
>memory leaks and double-frees.
>
>Fix this by pulling the calls to dma_{alloc,free}_coherent() out of the
>loops.
>
>While at it, remove the intermediate variable mem_decs (I guess it was
>only there to make the code comply to the 80-chars CodingSytle rule).
>
>Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Please don't merge the memory descriptors. The idea was initially to
allocate multiple small descriptors instead one big. The descrriptor
turned out to be enough so it looks like the way it looks.
If you want to clean this up, please either remove the for loop and
allocate only one memory area or please prepare for multiple descripors
(I think two is the upper limit).

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
