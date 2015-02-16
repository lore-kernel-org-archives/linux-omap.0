From: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Mon, 16 Feb 2015 11:26:36 +0200
Message-ID: <54E1B7CC.9080805@intel.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>	<1422173608-24355-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>	<54DCAF88.4010607@intel.com> <CAJ1gpc3fSpVyYx52xk+r+aPJt4YBcP+9wLGo9bUnX-EE1MP-VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJ1gpc3fSpVyYx52xk+r+aPJt4YBcP+9wLGo9bUnX-EE1MP-VQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 15.02.2015 16:29, Sneeker Yeh wrote:
> hi Mathias:
> 
> thanks for reviewing these patch,
> and sorry for replying lately~
> 

>>> +     status = readl(port_array[dev_port_num - 1]);
>>> +
>>> +     /* write 1 to clear */
>>> +     if (!(status & PORT_CONNECT) && (status & PORT_CSC))
>>> +             writel(status & PORT_CSC, port_array[0]);
>>
>> Shouldn't this be writel(...,port_array[dev_port_num - 1]) ?
> 
> yes, thanks for correcting this,
> and I also would like to add xhci_port_state_to_neutral() you mentioned.
> what would you think if I modify it like this?
> 
> +       /* write 1 to clear */
> +       if (!(status & PORT_CONNECT) && (status & PORT_CSC)) {
> +               status = xhci_port_state_to_neutral(status);
> +               writel(status | PORT_CSC, port_array[dev_port_num - 1]);
> +       }
> 

Looks good to me

-Mathias

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
