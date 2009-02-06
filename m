From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 2/3] usb: musb: fix bug in musb_start_urb
Date: Fri, 06 Feb 2009 18:03:55 +0300
Message-ID: <498C515B.20603@ru.mvista.com>
References: <1233921146-4046-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233921146-4046-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta wrote:

> urb->transfer_buffer_length and urb->transfer_buffer should be
> updated based on urb->actual_length.For a fresh and first time urb,
> actual_length will be zero but for urbs which has been stopped and
> restarted (as bulk nak scheme does) actual_length may not be zero.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

    NAK, this is not a problem for the current driver since URBs do not ever 
get restarted. Also, musb_host_tx() doesn't update urb->actual_length -- 
please fix it too. Also, you must not clear qh->iso_idx when restarting -- you 
must not start ISO transfer all over again too. Also, you should not set 
musb->ep0_state to MUSB_EP0_START again in this case (I agree that control 
transfers will remain not restartable from an arbitatry place even then).  If 
you're trying to make musb_start_urb() able to re-start, please be consistent.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
