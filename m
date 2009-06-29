From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: musb Rx DMA (Mentor) failure when one DMA receive is started
 before the previous completes (??)
Date: Mon, 29 Jun 2009 07:51:06 +0300
Message-ID: <20090629045106.GA25871@nokia.com>
References: <5a7b8b7b0906281950u2d135060x1e29fea44c1a7bd8@mail.gmail.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5a7b8b7b0906281950u2d135060x1e29fea44c1a7bd8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Hugo Vincent <hugo.vincent-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 29, 2009 at 04:50:38AM +0200, ext Hugo Vincent wrote:
> Hi all,
> 
> I'm still seeing a problem with musb receive DMA crashing when large
> transfers happen in rapid succession.
> 
> I've narrowed it down to this test case: Pinging the OMAP over USB
> ethernet gadget, with large (64K) ping packets. At the start, the
> system is otherwise idle. If the interval is set higher than the ping
> time (i.e. 0.05 = 50ms in the first example), then it doesn't crash.
> If I reduce the interval of these packets to 20 ms (second example
> below), then start loading the system (increasing the ping time
> through 20 ms), I see the crash (log below). Alternately, decreasing
> the ping interval to 10 ms causes the crash after one packet.
> 
> desktop ~$ sudo ping -i 0.05 -s 65507 192.168.2.2
> PING 192.168.2.2 (192.168.2.2) 65507(65535) bytes of data.
> 65515 bytes from 192.168.2.2: icmp_seq=1 ttl=64 time=19.4 ms
> 65515 bytes from 192.168.2.2: icmp_seq=2 ttl=64 time=19.4 ms
> 65515 bytes from 192.168.2.2: icmp_seq=3 ttl=64 time=19.4 ms
> ...
> --> Does NOT crash
> 
> desktop ~$ sudo ping -i 0.02 -s 65507 192.168.2.2
> PING 192.168.2.2 (192.168.2.2) 65507(65535) bytes of data.
> 65515 bytes from 192.168.2.2: icmp_seq=1 ttl=64 time=19.5 ms
> 65515 bytes from 192.168.2.2: icmp_seq=2 ttl=64 time=19.3 ms
> 65515 bytes from 192.168.2.2: icmp_seq=3 ttl=64 time=19.3 ms
> ...
> --> Does crash, as soon as the system is loaded a bit such that the
> ping time would increase beyond 20 ms.

I haven't managed to make it crash, but musb rtl 1.4 has a hw problem
where it can't handle simultaneous dma transfers. You have to use one
channel at a time.

One way to work around this issue, is to allocate channel on a
per-request basis. I have some patches for that but they're not clean
enough to be sent out and they probably break blackfin that has some
other issues with mentor dma.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
