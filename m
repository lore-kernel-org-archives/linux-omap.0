From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [OOPS] cppi41_dma_channel_program: Unable to handle kernel NULL
 pointer dereference
Date: Fri, 20 May 2016 16:12:36 -0500
Message-ID: <20160520211236.GB3432@uda0271908>
References: <1463750386-6259-1-git-send-email-matwey@sai.msu.ru>
 <CAJs94EZjWi0KGn_siyXNGvjO2DTh2aXtYqKzy7Km7mA_bYTeKg@mail.gmail.com>
 <20160520201019.GA3432@uda0271908>
 <CAJs94EZSwJ=sJv6NtR6RNdiugiSQQpam-TFRTn0uZZJ4MLsr5g@mail.gmail.com>
 <CAJs94EY3BfQjkk+0hKR5WfKggvmtgV0yz77awiX8Lt_pLYs3ug@mail.gmail.com>
 <CAJs94EZm3aV23x3hGHLpM4dAC+C9rH-ro3JbWU=se_QWv9jRmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJs94EZm3aV23x3hGHLpM4dAC+C9rH-ro3JbWU=se_QWv9jRmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Cc: Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, May 21, 2016 at 12:05:06AM +0300, Matwey V. Kornilov wrote:
> By the way, is it ok that function musb_rx_dma_iso_cppi41 uses
> hw_ep->tx_channel? I would suppose that it should use rx_channel
> instead.

I just got here, and am wondering the same. But the question is why just
your case hit the problem. I will try to look at it more next week.

I had an impression the linux-usb@ has a discussion before about
rx/tx-channel messing up, will have to look it up.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
