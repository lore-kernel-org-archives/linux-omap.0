From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v3 0/5] usb: musb_dsps: support for suspend and resume
Date: Fri, 18 Oct 2013 11:59:50 +0200
Message-ID: <52610696.7020900@linutronix.de>
References: <1382089175-13487-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382089175-13487-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/18/2013 11:39 AM, Daniel Mack wrote:
> v3 of my musb_dsps suspend patches.
> 
> With these patches applied, I can successfully bring an AM335x board
> to suspend with a USB media connected, and access it again after
> resume.
> 
> This works for both PIO mode and CPPI41 enabled configurations,
> together with Sebasitian's and my cppi41 patches recently posted.
> 
> Felipe, this work was rebased and now applies cleanly on top of
> your current 'next' branch. IOW, on top of "usb: musb: cppi41: allow
> to defer probing if DMA isn't yet available".

Sounds good. What happend to the patch series where you used a
workqueue do defer some sleeping code that caused "sleeping while
atomic" warnings?

> 
> Thanks,
> Daniel
> 

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
