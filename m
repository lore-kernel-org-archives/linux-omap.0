From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Thu, 7 Oct 2010 10:43:00 +0300
Message-ID: <20101007074300.GF686@legolas.emea.dhcp.ti.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 06, 2010 at 06:33:23PM -0500, Grazvydas Ignotas wrote:
>Hi,
>
>pulled today's linux-next and g_ether is acting strange on my pandora board:
># ping pnd
>PING pnd (10.0.1.2) 56(84) bytes of data.
>64 bytes from pnd (10.0.1.2): icmp_seq=2 ttl=64 time=2018 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=1 ttl=64 time=5036 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=8 ttl=64 time=1019 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=6 ttl=64 time=4030 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=10 ttl=64 time=4025 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=16 ttl=64 time=18.2 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=15 ttl=64 time=2019 ms
>64 bytes from pnd (10.0.1.2): icmp_seq=14 ttl=64 time=4022 ms
>
>Looks like the transfers get mixed somehow? Curiously after replugging
>the cable several times it starts working properly, however the
>problem comes back reliably after each reboot.

hmm, good catch. We need to debug that and send a patch after -rc0. Greg
already queued all patches, so it's difficult to change anything now.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
