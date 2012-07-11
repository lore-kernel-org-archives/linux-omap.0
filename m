From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Wed, 11 Jul 2012 18:23:48 +0530
Message-ID: <CAP05o4JZNeh2BCxkfUVajYLGdzPG30v++-EYjLD09OmS1uqyyQ@mail.gmail.com>
References: <87ehp71liv.fsf@ti.com>
	<20120622203645.GD29290@arwen.pp.htv.fi>
	<87d34nfdei.fsf@ti.com>
	<871uku85o8.fsf@ti.com>
	<CAP05o4+hxt6zY0AxK5aNW7a3Hyiw0_krP9=XK_prN5=Uk2SxmA@mail.gmail.com>
	<CAP05o4KinrK7N13nivOy+reibY526c8sv6ySkxwDZwDMJHSaiQ@mail.gmail.com>
	<87k3yj4pn4.fsf@ti.com>
	<20120705111901.GR22065@sortiz-mobl>
	<CAP05o4JEx0uSCH+mZzLhoV479A00uUumvYY_-b8dQ9j_5Awumw@mail.gmail.com>
	<CAP05o4+OBPBzqurM2FHDBmQ0AbBLVHL5DP+cMHW+jS5bG23-EQ@mail.gmail.com>
	<20120711102958.GA23772@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120711102958.GA23772@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2012 at 3:59 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi Keshava, Kevin,
>
> On Fri, Jul 06, 2012 at 05:29:00PM +0530, Munegowda, Keshava wrote:
>> Samuel
>>           I have sent that patch to disable the ehci in
>> omap2plus_defconfig; after merging that
>> please merge this patch too. This will fix the crashes in during boot
>> with NFS in beagleXM
> I'm going to apply and push this patch for 3.5, and the defconfig patch can be
> pushed through Tony's tree.
> Kevin, could you please ACK it ?
>
> Cheers,
> Samuel.
>

Thanks Samuel

Kevin,
    need your ack for this.
The commit id 354ab8567ae3107a8cbe7228c3181990ba598aac titled
"Fix OMAP EHCI suspend/resume failure (i693)",
is handling the clocks in ehci driver which is not correct,
it will be through the usb host driver ( /mfd/omap-usb_host.c )  exporting
APIs to ehci driver to handler the port clocks.

for now, this patch is necessary to remove the
 commit id 354ab8567ae3107a8cbe7228c3181990ba598aac titled
"Fix OMAP EHCI suspend/resume failure (i693)",

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
