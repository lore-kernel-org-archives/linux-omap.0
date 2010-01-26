From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 21:15:06 +0200
Message-ID: <20100126191506.GD20049@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <201001260316.20529.david-b@pacbell.net>
 <20100126141016.GD10690@nokia.com>
 <201001260707.23339.david-b@pacbell.net>
 <20100126190934.GC20049@nokia.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100126190934.GC20049-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 26, 2010 at 08:09:34PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>well, if you have access to twl5031 docs you'd understand what I'm
>talking about, the charger detection involves at least 3 blocks on
>twl5031 plus musb to enable/disable pullups. The sequence is pretty much
>as below:

there's more which I forgot:

>1. vbus irq
>2. usb_gadget_disconnect()
>3. disable usb ldos

3.1 put transceiver in non-drivig mode

>4. switch usb3v1 supply from vbat to vbus (to let charger detection work
>on low bat)
>5. enable usb3v1 *only*
>6. call the notifier chain
>7. BCC module kicks charger detection
>8. disable usb3v1
>9. switch usb3v1 supply back to vbat

9.1 put transceiver back to normal mode

>10. enable usb ldos
>11. usb_gadget_connect() (necessary since we might be connected to
>charging port)

now it should be all fine.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
