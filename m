From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Wed, 30 Mar 2011 18:50:17 +0300
Message-ID: <BANLkTi=SocUuraFrX04LEhei1foJ8DDOHw@mail.gmail.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com>
	<201103301137.10916.laurent.pinchart@ideasonboard.com>
	<4D93352D.7090908@maxwell.research.nokia.com>
	<201103301556.56822.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53640 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab1C3PuS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 11:50:18 -0400
Received: by iwn34 with SMTP id 34so1394294iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 08:50:17 -0700 (PDT)
In-Reply-To: <201103301556.56822.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

On Wed, Mar 30, 2011 at 4:56 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 30 March 2011 15:50:37 Sakari Ailus wrote:
>> Laurent Pinchart wrote:
>> > Hi Sakari,
>>
>> Hi Laurent,
>>
>> > On Wednesday 30 March 2011 10:16:56 Sakari Ailus wrote:
>> >> Laurent Pinchart wrote:
>> >>> On Friday 25 March 2011 20:37:55 Ramirez Luna, Omar wrote:
>> >>>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> This patchset is aimed to fix a problem in arch_iommu implemen=
tation
>> >>>>> references. When an actual arch_iommu implementation is not lo=
aded
>> >>>>> while iommu_get() is being called results to a kernel oops, as=
 well
>> >>>>> as removing an arch_iommu implementation which is in use.
>> >>>>
>> >>>> How about fixing the dependency instead? Right now iommu2 depen=
ds on
>> >>>> iommu because of the calls to
>> >>>> install_iommu_arch/uninstall_iommu_arch... we should change tha=
t
>> >>>> dependency to iommu depend on iommu2. Something like iommu (pla=
t)
>> >>>> querying iommu2 (mach) for devices to install.
>> >>>
>> >>> The reason why iommu depends on iommu2 and not the other way aro=
und is
>> >>> because several mach-specific iommu implementations should be ab=
le to
>> >>> coexist in the same kernel. The right one should be loaded at ru=
ntime.
>> >>>
>> >>> I think that Sakari's patches correcty fix the problems he notic=
ed.
>> >>> However, they won't fix one basic issue, which is that the iommu=
2
>> >>> module won't be automatically pulled in when the omap3isp module=
 is
>> >>> loaded. The omap3isp driver will then fail to probe the device. =
That's
>> >>> better than crashing though.
>> >>
>> >> One option would be to specify the name of the module in the plat=
form
>> >> data and request_module() that in omap_iommu_probe(). This would =
solve
>> >> the issue, not sure how pretty is this though.
>> >
>> > Do we need that ? My understanding is that a machine will need a s=
ingle
>> > mach- specific iommu implementation only. Drivers shouldn't need t=
o care
>> > about that.
>>
>> Well, no more than that there would have to be a driver for the IOMM=
U
>> for that very hardware.
>>
>> > The iommu implementation should be automatically selected based on=
 the
>> > machine time.
>>
>> Machine type?
>>
>> I agree, but where is the selection made?
>
> The selection can be made by board code, or by the iommu implementati=
ons
> themselves if they're compiled in.

I prefer the first option. The second one will make the current
implementation be even more OMAP-only.
We have basically 3 layers:
IOVMM, IOMMU_GENERIC and IOMMU_SPECIFIC. The middle one should be
generic and don't care about machine types. The later one can be
handled by board code as it's machine specific and, for most of the
cases, I see no reason to let any other implementation besides the
machine type's to be loaded.

But the generic layer should not depend on any specific one. If
somebody decides to load the specific layer after the generic one, it
cannot be a problem.

Regards,

David

>
> --
> Regards,
>
> Laurent Pinchart
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
