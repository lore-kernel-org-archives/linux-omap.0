From: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume support
 of ehci and ohci
Date: Mon, 4 Jul 2011 14:56:30 +0530
Message-ID: <99b22453092fc32b751c3e7d0223c7eb@mail.gmail.com>
References: <1309546474-15363-7-git-send-email-keshava_mgowda@ti.com>
 <Pine.LNX.4.44L0.1107011504530.1624-100000@iolanthe.rowland.org>
 <11640ef76f97628579e457b5c6a74cc3@mail.gmail.com> <20110704082553.GH15044@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110704082553.GH15044-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, Vishwanath Sripathy <vishwanath.bs-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
>Sent: Monday, July 04, 2011 1:56 PM
>To: Partha Basak
>Cc: Alan Stern; Keshava Munegowda; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Felipe Balbi; Anand
>Gadiyar; sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org;
>Kevin Hilman; Benoit Cousson; paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org; johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org;
>Vishwanath Sripathy
>Subject: Re: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume
>support of ehci and ohci
>
>Hi,
>
>On Mon, Jul 04, 2011 at 10:36:54AM +0530, Partha Basak wrote:
>> >-----Original Message-----
>> >From: Alan Stern [mailto:stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org]
>> >Sent: Saturday, July 02, 2011 12:37 AM
>> >To: Keshava Munegowda
>> >Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> >kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org; gadiyar-l0cyMroinI0@public.gmane.org;
>> >sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org;
>> >khilman-l0cyMroinI0@public.gmane.org; b-cousson-l0cyMroinI0@public.gmane.org; paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org;
>> >johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org; vishwanath.bs-l0cyMroinI0@public.gmane.org
>> >Subject: Re: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume
>> >support of ehci and ohci
>> >
>> >On Sat, 2 Jul 2011, Keshava Munegowda wrote:
>> >
>> >> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >>
>> >> The global suspend and resume functions for ehci and ohci drivers
>> >> are implemented; these functions does the pm_runtime_get_sync and
>> >> pm_runtime_put_sync of the parent device usbhs core driver
>> >> respectively.
>> >>
>> >> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >> ---
>> >>  drivers/usb/host/ehci-omap.c  |   22 ++++++++++++++++++++--
>> >>  drivers/usb/host/ohci-omap3.c |   21 +++++++++++++++++++++
>> >>  2 files changed, 41 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-
>> >omap.c
>> >> index 178f63e..a02a684 100644
>> >> --- a/drivers/usb/host/ehci-omap.c
>> >> +++ b/drivers/usb/host/ehci-omap.c
>> >> @@ -259,14 +259,32 @@ static void ehci_hcd_omap_shutdown(struct
>> >platform_device *pdev)
>> >>  		hcd->driver->shutdown(hcd);
>> >>  }
>> >>
>> >> +static int omap_ehci_resume(struct device *dev) {
>> >> +	if (dev->parent)
>> >> +		pm_runtime_get_sync(dev->parent);
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int omap_ehci_suspend(struct device *dev) {
>> >> +	if (dev->parent)
>> >> +		pm_runtime_put_sync(dev->parent);
>> >> +	return 0;
>> >> +}
>> >
>> >I don't see any point in these routines (and likewise for
>> >omap_ohci_suspend/resume).  When the whole system is going to sleep
>> >anyway, what reason is there for enabling runtime PM on the parent
>> >device?
>>
>> Both for EHCI & OHCI, the clocks are owned by the parent (uhh-tll).
>>
>> Calling pm_runtime_put_sync(dev->parent) within omap_ehci_suspend will
>> turn-off the parent clocks in the Suspend path.
>>
>> Similarly, calling pm_runtime_get_sync(dev->parent) within
>> omap_ehci_resume will turn-on the parent clocks in the resume path.
>>
>> This way, all reference counting are implicit within the Runtime PM
>> layer and takes care of all combinations of only EHCI insmoded, OHCI
>> insmoded, both insmoded etc.
>>
>> When both EHCI & OHCI are suspended, parent clocks will actually be
>> turned OFF and vice-versa.
>
>not sure this is necessary. I would expect:
>
>pm_runtime_get_sync(dev) to propagate up the parent tree and enable all
>necessary resources to get the child in a working state. IOW, you
>shouldn't need to manuall access the parent device.
>
Refer to the description in Patch(5/6)
<snip>
In fact, the runtime framework takes care the get sync and put sync of the
child
in turn call the get sync and put sync of parent too; but calling get sync
and
put sync of parent is by ASYNC mode;
This mode queues the work item in runtime pm work queue,
which not getting scheduled in case of global suspend path.
<snip>
This approach was tried, but did not work in the Suspend path
static int rpm_suspend(struct device *dev, int rpmflags)
	__releases(&dev->power.lock) __acquires(&dev->power.lock)
{
.
.
.
no_callback:
.
.
.
	/* Maybe the parent is now able to suspend. */
	if (parent && !parent->power.ignore_children &&
!dev->power.irq_safe) {
		spin_unlock(&dev->power.lock);

		spin_lock(&parent->power.lock);
		rpm_idle(parent, RPM_ASYNC);
		spin_unlock(&parent->power.lock);

		spin_lock(&dev->power.lock);
	}
This is the reason of directly calling the parent Runtime PM calls from
the children.
If directly calling Runtime PM APIs with parent dev-pointer isn't
acceptable,
this can be achieved by exporting wrapper APIs from the
parent and calling them from the chidren .suspend/.resume routines.

>Kevin ? Paul ?
>
>--
>balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
