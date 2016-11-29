From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mfd: cpcap: Add minimal support
Date: Tue, 29 Nov 2016 09:20:17 -0600
Message-ID: <CAL_Jsq+8_O483raD97B8-ssaFGeVOPJcadyY4x7m0T64EbVA3g@mail.gmail.com>
References: <20161119012748.17224-1-tony@atomide.com> <20161121114558.GJ32509@dell>
 <20161123152652.GB4082@atomide.com> <20161124085926.GV10134@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161124085926.GV10134-Re9dqnLqz4GzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 24, 2016 at 2:59 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, 23 Nov 2016, Tony Lindgren wrote:
>
>> * Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161121 03:43]:
>> > On Fri, 18 Nov 2016, Tony Lindgren wrote:
>> > > --- a/drivers/mfd/Makefile
>> > > +++ b/drivers/mfd/Makefile
>> > > @@ -97,6 +97,7 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)   += mc13xxx-i2c.o
>> > >  obj-$(CONFIG_MFD_CORE)           += mfd-core.o
>> > >
>> > >  obj-$(CONFIG_EZX_PCAP)           += ezx-pcap.o
>> > > +obj-$(CONFIG_MFD_CPCAP)          += cpcap.o
>> >
>> > Who is the manufacturer?
>>
>> Hmm that I don't know. There seems to be both ST and TI versions
>> of this chip manufactured for Motorola. So my guess is that it
>> should be Motorola unless there's some similar catalog part
>> available from ST used by others. If anybody has more info
>> on this please let me know :)
>
> If this IP is shared amongst vendors, it usually means it was designed
> by someone else?  Synopsis perhaps?

xCAP names originated from Motorola cellular group with parts (going
back to analog/2G days) coming from Motorola Semi, TI, and ST it
seems. All individually developed AFAIK.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
