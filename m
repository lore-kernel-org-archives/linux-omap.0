From: tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [RESEND/PATCH 0/6] USB: musb-gadget: bug fix
Date: Tue,  7 Sep 2010 23:23:28 +0800
Message-ID: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch set fixes two kinds of musb-gadget bug:

	-fix kernel panic if using out ep with FIFO_TXRX style

	-make double buffer mode usable, fix infinate hangs and buffer
	corrupt bug when using double buffer mode to do data transfer;
	now we can use musb double buffer reliably, so bootst performance
	about 30% compared with single buffer mode.
	
		[RESEND/PATCH 1/6] USB: musb-gadget: fix kernel panic if using out ep with FIFO_TXRX style(v1)
		[RESEND/PATCH 2/6] USB: musb-gadget: fix bulk IN infinite hangs in double buffer case
		[RESEND/PATCH 3/6] USB: musb-gadget: enable autoclear for OUT transfer in both DMA 0 and DMA 1
		[RESEND/PATCH 4/6] USB: musb-gadget: fix DMA length for OUT transfer
		[RESEND/PATCH 5/6] USB: musb-gadget: complete request only if data is transfered over
		[RESEND/PATCH 6/6] USB: musb-gadget: fix dma length in txstate

thanks,
Lei Ming

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
