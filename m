From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 20 Jul 2012 13:36:56 +0530
Message-ID: <CAP05o4+mEf4nxdSEF1uEpmgKPcOQ598vHTFMCXrkE_O92djupQ@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<20120719102013.GJ14302@arwen.pp.htv.fi>
	<20120719225405.GB32547@kroah.com>
	<20120719225523.GC32547@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120719225523.GC32547-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 20, 2012 at 4:25 AM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Thu, Jul 19, 2012 at 03:54:05PM -0700, Greg KH wrote:
>> On Thu, Jul 19, 2012 at 01:20:14PM +0300, Felipe Balbi wrote:
>> > Hi,
>> >
>> > On Thu, Jun 21, 2012 at 07:12:12PM +0530, Keshava Munegowda wrote:
>> > > This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
>> > > "Fix OMAP EHCI suspend/resume failure (i693)" is causing
>> > > the usb hub and device detection fails in beagle XM
>> > > causeing NFS not functional. This affects the core retention too.
>> > > The same commit logic needs to be revisted adhering to hwmod and
>> > > device tree framework.
>> > > for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
>> > > titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>> > >
>> > > This patch is validated on BeagleXM with NFS support over
>> > > usb ethernet and USB mass storage and other device detection.
>> > >
>> > > Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >
>> > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> >
>> > turns out this is causing other issues and another version of the patch
>> > will be provided.
>> >
>> > Greg, Alan, this is basically a git revert of the commit id listed
>> > above.
>>
>> Ok, I'll queue it up for 3.6-rc1 and add a -stable mark to it to get
>> into 3.5.1, ok?
>
> Hm, that doesn't work as it doesn't apply to my tree :(
>
> Can someone please update this against usb-next and send it to me?
> Felipe?

Hi Greg
    yes, I will do this
I will send the v2 of this patch ASAP

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
