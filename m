From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 3 Apr 2013 15:12:11 +0200
Message-ID: <62C108BE-894A-4F1D-BE85-14DB3217120E@dominion.thruhere.net>
References: <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk> <5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com> <513A1580.90303@gmail.com> <514863BD.5010503@gmail.com> <87620nwmd2.fsf@dell.be.48ers.dk> <515C19D7.6080702@gmail.com> <20130403120454.GX25837@arwen.pp.htv.fi> <515C23D4.3010206@gmail.com> <20130403130807.GB14680@arwen.pp.htv.fi>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130403130807.GB14680-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Op 3 apr. 2013, om 15:09 heeft Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> het volgende geschreven:

> Hi,
> 
> On Wed, Apr 03, 2013 at 02:43:00PM +0200, Daniel Mack wrote:
>> On 03.04.2013 14:04, Felipe Balbi wrote:
>>> On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
>> 
>>>> Felipe, could you explain the background on how the dsps driver is
>>>> supposed to work in host mode at boot time with the rework of the driver
>>>> you did for 3.7? It might just be me not understanding the rationale
>>>> behind all these changes, but appearantly, I'm not the only one who's
>>>> affected by that.
>>> 
>>> right, so the idea with that was to drop the huge amount of ifdeferry
>>> hack from the MUSB driver. It would be great if someone would send
>>> *CLEAN* patches adding Kconfig-based role choices again.
>> 
>> Are Kconfig-based rules really what we want here after all? Wouldn't
>> run-time configured settings make much more sense, considering that
> 
> we need both. Say that you want to build a product with MUSB hardwired
> as host, why would you enable gadget framework ?
> 
> I can think of at least am335x where this would be perfectly plausible
> (no EHCI available, only MUSB).

Nice that you mention am335x, since the beaglebone has 2 MUSB controllers: one hardwired as host and one hardwired as slave. So how will KConfig options solve that?--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
