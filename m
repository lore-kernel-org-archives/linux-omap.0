From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Wed, 11 Jul 2012 07:23:35 -0700
Message-ID: <874npenzq0.fsf@ti.com>
References: <87ehp71liv.fsf@ti.com> <20120622203645.GD29290@arwen.pp.htv.fi>
	<87d34nfdei.fsf@ti.com> <871uku85o8.fsf@ti.com>
	<CAP05o4+hxt6zY0AxK5aNW7a3Hyiw0_krP9=XK_prN5=Uk2SxmA@mail.gmail.com>
	<CAP05o4KinrK7N13nivOy+reibY526c8sv6ySkxwDZwDMJHSaiQ@mail.gmail.com>
	<87k3yj4pn4.fsf@ti.com> <20120705111901.GR22065@sortiz-mobl>
	<CAP05o4JEx0uSCH+mZzLhoV479A00uUumvYY_-b8dQ9j_5Awumw@mail.gmail.com>
	<CAP05o4+OBPBzqurM2FHDBmQ0AbBLVHL5DP+cMHW+jS5bG23-EQ@mail.gmail.com>
	<20120711102958.GA23772@sortiz-mobl>
	<CAP05o4JZNeh2BCxkfUVajYLGdzPG30v++-EYjLD09OmS1uqyyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33730 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab2GKOXl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 10:23:41 -0400
Received: by yenl12 with SMTP id l12so2202431yen.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 07:23:35 -0700 (PDT)
In-Reply-To: <CAP05o4JZNeh2BCxkfUVajYLGdzPG30v++-EYjLD09OmS1uqyyQ@mail.gmail.com>
	(Keshava Munegowda's message of "Wed, 11 Jul 2012 18:23:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>, Russ.Dill@ti.com

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Wed, Jul 11, 2012 at 3:59 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> Hi Keshava, Kevin,
>>
>> On Fri, Jul 06, 2012 at 05:29:00PM +0530, Munegowda, Keshava wrote:
>>> Samuel
>>>           I have sent that patch to disable the ehci in
>>> omap2plus_defconfig; after merging that
>>> please merge this patch too. This will fix the crashes in during boot
>>> with NFS in beagleXM
>> I'm going to apply and push this patch for 3.5, and the defconfig patch can be
>> pushed through Tony's tree.
>> Kevin, could you please ACK it ?
>>
>> Cheers,
>> Samuel.
>>
>
> Thanks Samuel
>
> Kevin,
>     need your ack for this.

You never answered earlier questions from myself or Russ Dill about the
more targetted patches from Russ:

   ARM: OMAP: USB: Fixup ehci_hcd_omap_probe error path
   Fix OMAP EHCI suspend/resume failure (i693) '354ab856' causes

Also, your current $SUBJECT patch is large and not well
described. e.g. what is "not correct" and why.  Why does it fix the
problems mentioned?  The original changelog mentions the "core retention
issue" but this patch does nothing to address that.  If you want an Ack
from me, especially because I'm not an expert in this IP, you'll have to
describe things in a way that I can understand.

IMO, at this point of the dev cycle (trying to stabilize v3.5), the full
cleanup/fix of this feature will need to be done for v3.6.  For v3.5, I
think the two patches from Russ Dill should be merged.   They are
targetted fixes and very well described.

Kevin

> The commit id 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> "Fix OMAP EHCI suspend/resume failure (i693)",
> is handling the clocks in ehci driver which is not correct,
> it will be through the usb host driver ( /mfd/omap-usb_host.c )  exporting
> APIs to ehci driver to handler the port clocks.
>
> for now, this patch is necessary to remove the
>  commit id 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> "Fix OMAP EHCI suspend/resume failure (i693)",
>
> regards
> keshava
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
