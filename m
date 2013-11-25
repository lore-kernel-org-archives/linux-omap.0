From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Mon, 25 Nov 2013 20:58:22 +0100
Message-ID: <5293ABDE.4080404@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-3-git-send-email-zonque@gmail.com> <20131125194629.GA18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131125194629.GA18046-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/25/2013 08:46 PM, Felipe Balbi wrote:
> On Mon, Nov 25, 2013 at 08:39:50PM +0100, Daniel Mack wrote:
>> Make musb_port_suspend() externally available, and call it when to host
>> goes into suspend. This allows the core to go into suspend while a
>> device is connected.
>>
>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/usb/musb/musb_host.c    | 2 ++
>>  drivers/usb/musb/musb_host.h    | 2 ++
>>  drivers/usb/musb/musb_virthub.c | 2 +-
>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
>> index 6582a20..81caf9f 100644
>> --- a/drivers/usb/musb/musb_host.c
>> +++ b/drivers/usb/musb/musb_host.c
>> @@ -2433,6 +2433,8 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
>>  	struct musb	*musb = hcd_to_musb(hcd);
>>  	u8		devctl;
>>  
>> +	musb_port_suspend(musb, true);
> 
> have you considered the fact that when musb looses context it'll cause a
> disconnect on the bus because soft_connect bit is lost ?
>
> What if you have a mounted file system on a pendrive ? Should we allow
> suspend in that case ?

Well, I would have expected that, but in fact, the opposite is true.
With 3.12, mounting a filesystem on a USB media and accessing it after
resume was exactly my test case, and it worked just fine with that patch.

In 3.13, something about the parition table reading seems to be broken
currently, I'll have a closer look.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
