From: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume support
 of ehci and ohci
Date: Thu, 7 Jul 2011 10:23:59 +0530
Message-ID: <94f8609ab03603c27ef2cf3850bb92e6@mail.gmail.com>
References: <Pine.LNX.4.44L0.1107051018580.2060-100000@iolanthe.rowland.org>
 <8762ngtyqj.fsf@ti.com> <20110706175412.GH10729@legolas.emea.dhcp.ti.com>
 <87sjqji5br.fsf@ti.com> <20110706221738.GA823@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110706221738.GA823-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, Vishwanath Sripathy <vishwanath.bs-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
>Sent: Thursday, July 07, 2011 3:48 AM
>To: Kevin Hilman
>Cc: balbi-l0cyMroinI0@public.gmane.org; Alan Stern; Partha Basak; Keshava Munegowda; linux-
>usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anand Gadiyar; sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
>parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Benoit Cousson; paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org;
>johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org; Vishwanath Sripathy
>Subject: Re: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume
>support of ehci and ohci
>
>Hi,
>
>On Wed, Jul 06, 2011 at 12:20:40PM -0700, Kevin Hilman wrote:
>> >> +	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
>> >> +	    (od->_state == OMAP_DEVICE_STATE_IDLE))
>> >> +		omap_device_enable(pdev);
>> >> +
>> >> +	return pm_generic_resume(dev);
>> >> +}
>> >> +
>> >>  static struct dev_power_domain omap_device_power_domain = {
>> >>  	.ops = {
>> >>  		.runtime_suspend = _od_runtime_suspend,
>> >>  		.runtime_idle = _od_runtime_idle,
>> >>  		.runtime_resume = _od_runtime_resume,
>> >>  		USE_PLATFORM_PM_SLEEP_OPS
>> >> +		.suspend = _od_suspend,
>> >> +		.resume = _od_resume,
>> >>  	}
>> >>  };
>> >
>> > it all depends on when are you planning to get this patch upstream.
>> > I'm considering getting some PM working on USB host and remove the
>> > pm_runtime calls from system suspend/resume either during -rc or
>> > next merge window.
>>
>> Well, IMO it's way too late for this kind of change for -rc, so I'm
>> considering it for the upcoming merge window.
>
>yes, that's true. Who should take the hwmod patches btw ? I'm still
>wondering if we should patch hwmod data first and push the _correct_ PM
>part on 3.2.

Once Kevin pushes this infrastructure enhancement, all drivers have to
rework
the Suspend/Resume anyways. Another way would be to go by the current
approach
now and then do the rework in 3.2 along with other drivers.

In this way, we can soak the Runtime support of EHCI/OHCI for one merge
window.
>
>--
>balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
