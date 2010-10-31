From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Sun, 31 Oct 2010 01:28:49 -0400
Message-ID: <4CCCFE91.9000207@ti.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>	<AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>	<AANLkTimYJ-hyNm7nx+dvTrgO4QC2YSjBYjLqHR_wvGni@mail.gmail.com>	<AANLkTim_xYch-BS0Edc70679Rx03fpofpoGSkTzQV1HW@mail.gmail.com>	<4CC84109.9040304@ti.com> <AANLkTikUqXpMhPfMV78sf4zusQ-h4JpE+eSgnnpE2PON@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikUqXpMhPfMV78sf4zusQ-h4JpE+eSgnnpE2PON-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/28/2010 11:36 AM, Ming Lei wrote:
> Another question, musb_read_fifo and musb_write_fifo need to be fixed to
> use 32bit operation only alike am35x?

Nope - that limitation is only in certain AM35x SoCs. OMAP36xx/37xx are 
not affected.

- Anand

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
