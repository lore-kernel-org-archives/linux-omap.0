From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Thu, 12 Jul 2012 12:11:17 +0530
Message-ID: <CAP05o4+hQh-weQ_hfFMxY-byEijwDF3e-D9U5gwh6yRD7C_=Zw@mail.gmail.com>
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
	<CAP05o4JZNeh2BCxkfUVajYLGdzPG30v++-EYjLD09OmS1uqyyQ@mail.gmail.com>
	<874npenzq0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874npenzq0.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2012 at 7:53 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>
>> On Wed, Jul 11, 2012 at 3:59 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>> Hi Keshava, Kevin,
>>>
>>> On Fri, Jul 06, 2012 at 05:29:00PM +0530, Munegowda, Keshava wrote:
>>>> Samuel
>>>>           I have sent that patch to disable the ehci in
>>>> omap2plus_defconfig; after merging that
>>>> please merge this patch too. This will fix the crashes in during boot
>>>> with NFS in beagleXM
>>> I'm going to apply and push this patch for 3.5, and the defconfig patch can be
>>> pushed through Tony's tree.
>>> Kevin, could you please ACK it ?
>>>
>>> Cheers,
>>> Samuel.
>>>
>>
>> Thanks Samuel
>>
>> Kevin,
>>     need your ack for this.
>
> You never answered earlier questions from myself or Russ Dill about the
> more targetted patches from Russ:
>
>    ARM: OMAP: USB: Fixup ehci_hcd_omap_probe error path
>    Fix OMAP EHCI suspend/resume failure (i693) '354ab856' causes
>
> Also, your current $SUBJECT patch is large and not well
> described. e.g. what is "not correct" and why.  Why does it fix the
> problems mentioned?  The original changelog mentions the "core retention
> issue" but this patch does nothing to address that.  If you want an Ack
> from me, especially because I'm not an expert in this IP, you'll have to
> describe things in a way that I can understand.
>
> IMO, at this point of the dev cycle (trying to stabilize v3.5), the full
> cleanup/fix of this feature will need to be done for v3.6.  For v3.5, I
> think the two patches from Russ Dill should be merged.   They are
> targetted fixes and very well described.
>
> Kevin
>


Hi Kevin
        The usb2 host of omap3/4/5 silicons has the following ips

1. UHH   (  /drivers/mfd/omap-usb-host.c ) -- platform driver
2. TLL    ( /drivers/mfd/omap-usb-host.c )
3. ehci    ( /drivers/usb/host/ehci-omap.c)  - platform driver
4. ohci ( /drivers/usb/host/ohci-omap3.c ) - platform drivers

The 3 platform drivers exists to make the ehci/ohci functional.

The  UHH-TLL or usb host core driver is the parent platform driver of
ehci and ohci.
This parent driver doe the clock enable/disable which common for both
ehci and ohci.
takes care of common port setting and clocks during suspend and resume
and ensures
that there is no overwrites by ehci and ohci platform drivers.

The commit id  354ab8567ae3107a8cbe7228c3181990ba598aac titled
"Fix OMAP EHCI suspend/resume failure (i693)" was handling the clocks in
the ehci driver it self, instead it should be handled by usb host core
driver  as per above
explanation. so, the UHH-TLL Driver should handle the changes done by
354ab8567ae3107a8cbe7228c3181990ba598aac.


hence this patch removes the changed done by the commit id
354ab8567ae3107a8cbe7228c3181990ba598aac

suppose if this patch is not included, then it will cause the
following two problems

1.  crash during the system boot
                       - observed in beagle xm , with NFS file system
                                           the Ethernet is through
ehci driver , since the ehci ports clocks are not handled properly
                         by this commit id
354ab8567ae3107a8cbe7228c3181990ba598aac,  it leads to crash

2. crash during suspend/resume
                  - observed in beagle xm with ram fs
                                     if the ehci is driver is included
and if it tries to suspend it leads to crash

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
