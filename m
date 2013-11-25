From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Mon, 25 Nov 2013 21:47:16 +0100
Message-ID: <5293B754.9050406@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-3-git-send-email-zonque@gmail.com> <20131125194629.GA18046@saruman.home> <5293ABDE.4080404@gmail.com> <20131125200121.GE18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131125200121.GE18046-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/25/2013 09:01 PM, Felipe Balbi wrote:
> On Mon, Nov 25, 2013 at 08:58:22PM +0100, Daniel Mack wrote:

>> In 3.13, something about the parition table reading seems to be broken
>> currently, I'll have a closer look.
> 
> cool

Ah, and forget about this one. I didn't look close enough. There's no
such issue in 3.13. Sorry for the noise.




--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
