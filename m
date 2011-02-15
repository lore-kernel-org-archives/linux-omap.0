From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v6] usb: musb: Using runtime pm APIs for musb.
Date: Tue, 15 Feb 2011 09:31:45 +0530
Message-ID: <AANLkTinO0uThn=xOwsdhy8F-1p-eHvdT1+a+BOyLtK9R@mail.gmail.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
	<1297346881-13438-6-git-send-email-hemahk@ti.com>
	<20110210142605.GR3580@legolas.emea.dhcp.ti.com>
	<98ff144ea4e715250c54712ebbfb494f@mail.gmail.com>
	<87oc6ew2lh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87oc6ew2lh.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 15, 2011 at 6:12 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org> writes:
>
> [...]
>
>>>On Thu, Feb 10, 2011 at 07:38:01PM +0530, Hema HK wrote:
>>>> Calling runtime pm APIs pm_runtime_put_sync() and
>>>pm_runtime_get_sync()
>>>> for enabling/disabling the clocks, sysconfig settings.
>>>>
>>>> Enable clock, configure no-idle/standby when active and
>>>configure force idle/standby
>>>> and disable clock when idled. This is taken care by the
>>>runtime framework when
>>>> driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
>>>
>>>does it have to be the _sync() ??
>> Yes. Because immediately after this I access the registers.
>>
>
> What about the put?

Put can be async. I will send the patch with changes.

Regards,
Hema

>
> Kevin
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
