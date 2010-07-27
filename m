From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: Issue with file transfers to a mass storage device on SMP
	system
Date: Tue, 27 Jul 2010 11:01:21 +0100
Message-ID: <20100727100121.GB7846@n2100.arm.linux.org.uk>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 27, 2010 at 03:08:54PM +0530, Shilimkar, Santosh wrote:
> As discussed, the main reason is the cache maintenance isn't done on
>  "bcb->CDB"  buffers and hence the data remains in CPU write buffer
> instead of the physical memory on which DMA operates. 

struct bulk_cb_wrap {
        __le32  Signature;              /* contains 'USBC' */
        __u32   Tag;                    /* unique per command id */
        __le32  DataTransferLength;     /* size of data */
        __u8    Flags;                  /* direction in bit 0 */
        __u8    Lun;                    /* LUN normally 0 */
        __u8    Length;                 /* of of the CDB */
        __u8    CDB[16];                /* max command */
};

So, CDB is contained within bcb...bcb+sizeof(*bcb).

The bcb is passed to usb_stor_bulk_transfer_buf:

        result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
                                bcb, cbwlen, NULL);

which fills it into a URB:

        usb_fill_bulk_urb(us->current_urb, us->pusb_dev, pipe, buf, length,
                      usb_stor_blocking_completion, NULL);

This sets the URB buffer pointers:

        urb->transfer_buffer = transfer_buffer;
        urb->transfer_buffer_length = buffer_length;

And this buffer should be dma-mapped and dma-unmapped as appropriate.

Wasn't there an issue with the DMA mapping being used with a PIO USB
host recently?  Is that the problem here?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
