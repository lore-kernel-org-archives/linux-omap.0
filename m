From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v2 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Wed, 02 Oct 2013 14:01:17 +0200
Message-ID: <524C0B0D.3020300@linutronix.de>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com> <1380634797-29541-3-git-send-email-zonque@gmail.com> <20131002104910.GD16680@linutronix.de> <524C001B.8040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524C001B.8040901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/02/2013 01:14 PM, Daniel Mack wrote:
> On 02.10.2013 12:49, Sebastian Andrzej Siewior wrote:
>> * Daniel Mack | 2013-10-01 15:39:54 [+0200]:
>>
>>> Make musb_port_suspend() externally available, and call it when to host
>>> goes into suspend. This allows the core to go into suspend while a
>>> device is connected.
>>
>> Sorry for asking this stupid question but what is usally happening when
>> the host goes to suspend and a device is connected? I think it is
>> disconnected & re-enumerated and resume and this not what you want,
>> right?
> 
> It is usually put into USB suspend and the host preserves its state.
> After resume, the usb storage driver, for example, will not register new
> partitions but expect things to be as they were before. That is, your
> previously mounted devices remain functional.
> 
> However, the enumeration process has to be done again, because when the
> device looses power, it can't memorize its address.
> 
>> What happens if the device is unplugged while the host is suspended and
>> not there on resume?
> 
> That condition is detected and a full teardown of the connected drivers
> is conducted. Try what happens on your notebook when you do that.
> Embedded systems should behave just the same.

I had the feeling that the USB device gets disconnected and
re-enumerated on resume. But if you say that the ehci-hcd saves the
state and keeps the device connected if it wasn't disconnected during
suspend then there is no reason for musb to behave differently.

> Daniel

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
