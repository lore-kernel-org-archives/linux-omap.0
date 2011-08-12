From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Fri, 12 Aug 2011 11:50:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108121149160.11936-100000@netrider.rowland.org>
References: <1313159931-22121-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313159931-22121-1-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, axelhaslam-l0cyMroinI0@public.gmane.org, ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 12 Aug 2011, Vikram Pandita wrote:

> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> 
> musb pm_runtime_get_sync call happens in intrrupt context on cable attach case
> That can result in re-enabling the interrupts and cause side affects.
> 
> So move the code to a work queue.

Instead of creating your own, new work queue, just use the pre-existing
PM work queue.  In other words, replace pm_runtime_get_sync() with
pm_runtime_get().

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
