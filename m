From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: MUSB Error Handling
Date: Thu, 2 Nov 2017 12:43:02 -0700
Message-ID: <20171102194302.GC28152@atomide.com>
References: <CAHCN7xLeZvqUQSi0Z25Ochwdm+OK5MjaVeiK85Wjhvg1=tp7Kg@mail.gmail.com>
 <20171031183307.GC65@LTA0271908.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171031183307.GC65-zlS79ln5qqxp6PWD+TyudpdHMjK6IpyN@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [171031 18:35]:
> Hi,
> 
> On Tue, Oct 31, 2017 at 12:56:40PM -0500, Adam Ford wrote:
> > We have a situation where occasionally the USB glitches where the D-
> > glitches low at or near an end of frame (EOF) or end of packet (EOP).
> > We're using the TWL4030 with MUSB on an OMAP3 processor.  We cannot
> > tell where the glitch is originating.
> > 
> >  We're working on resolving this in both hardware and software, but I
> > was hoping someone might have some insights on how to address it in
> > software.
> > 
> > We created a special test fixture to force the D- low for a moment
> > during the EOP and EOF to attempt to compare the handling of other USB
> > controllers and/or USB hubs.  The reason I think it's unique to the
> > MUSB controller or the TWL4030, because we cannot reproduce this issue
> > using other USB controllers and/or other USB controllers handle the
> > error condition.
> > 
> > On an older, 3.0.x kernel, if we get a glitch on D-, the MUSB
> > controller may become unresponsive to the point where a reboot becomes
> > required.
> > 
> > Testing this similar scenario with the 4.14-RC kernel, the MUSB
> > controller drops the connection and re-enumerates almost immediately,
> > which indicates to me that the error handling is getting better (or
> > the glitching is reduced somehow).  I have not seen a reboot be
> > required.
> > 
> > If I connect the same USB devices to a USB Hub and/or other USB
> > controller and attempt to force this same condition with the test
> > fixture, the high level USB code does not notice there is an error.
> > There is no disconnect, no hanging, no loss of data.
> > 
> > I am not a USB expert, but it seems like we might be able to handle
> > the error in software and/or retry if necessary without dropping the
> > connection.  Might someone have any ideas or thoughts on how we might
> > be able to tweak the software?
> 
> Does the uart console print any log message before re-enumeration happens
> with v4.14-rc? is there 'Babble'?
> 
> I cannot tell what could cause the glitches, which seems to be analog
> related, but I don't think there is any way in software can prevent
> dropping the connection. I suspect the glitches cause the babble condition,
> then the musb controller drops the connection, but the musb driver
> receives the babble event and restarts the enumeration. There is no
> software control to prevent the controller to drop the connection when
> babble happens.

This sounds like a different issue but because of the glitch on the
data lines might be worth checking..

It used to be that musb was trying to enumerate as a gadget on it's
own, maybe only if the bootloader had some gadget configured.

I think this issue is fixed now with commit a118df07f5b1 ("usb: musb:
Don't set d+ high before enable for 2430 glue layer"). So just to
make sure, have some gadget configured in the kernel for musb while
running your tests.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
