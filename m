From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/5 v6] OMAP2+: musb: HWMOD adaptation for musb. registration
Date: Wed, 16 Feb 2011 16:27:41 +0530
Message-ID: <f9b201dcd969fa777e650c72068a50c2@mail.gmail.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com><1297346881-13438-5-git-send-email-hemahk@ti.com><87vd0mw3u9.fsf@ti.com><20110215083235.GG2570@legolas.emea.dhcp.ti.com>
 <87r5b9uvj8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r5b9uvj8.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman-l0cyMroinI0@public.gmane.org]
>Sent: Tuesday, February 15, 2011 9:42 PM
>To: balbi-l0cyMroinI0@public.gmane.org
>Cc: Hema HK; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tony Lindgren; Cousson, Benoit;
>Paul Walmsley
>Subject: Re: [PATCH 4/5 v6] OMAP2+: musb: HWMOD adaptation for
>musb. registration
>
>Hi Felipe,
>
>Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>
>> On Mon, Feb 14, 2011 at 04:15:10PM -0800, Kevin Hilman wrote:
>>> Hema HK <hemahk-l0cyMroinI0@public.gmane.org> writes:
>>>
>>> > Using omap_device_build API instead of
>platform_device_register for
>>> > OMAP2430,OMAP34xx and OMAP4430 musb device registration.
>>> > The device specific resources defined in centralized
>>> > database will be used.
>>>
>>> Except for AM35x.
>>>
>>> NACK, for same reasons as previous version of this patch.
>>
>> Does it really make sense to hold on omap2plus HWMOD
>conversion because
>> of AM35x ? I mean, I understand it would be better to get
>all fixed up,
>> but loose another merge window for that ?
>>
>> Can we get omap2plus in and AM35x on the next merge window ? At least
>> omap2plus would have been converted to hwmod and would be using
>> pm_runtime as we want.
>
>Well, you get to decide as you're the maintainer of this stuff. ;)
>
>If you merge it, I suggest at least fixing the changelog to make it
>clear that not all devices are using hwmod.
>

I have a patch ready for adding hwmod for AM35x. But there is one issue
with
co-existance of omap3 musb hwmod and am35x. I think this is already a
problem
with current mainline with smart reflex hwmod changes.

For AM35x there is no separate CHIP_IS_*. So anything added in the omap3
hwmod database with CHIP_IS_OMAP3430 is considered for AM35x
and if that module soes not exists there will be crash.

I think for this issue Sanjeev Premi has send a mail on the
list.

>That being said, how difficult is it to add the hwmod data for
>the AM35x
>OTG block?   Just added it to the exising OMAP3 data using CHIP_IS* to
>marke it as AM35x, and you can at least get rid of the base address and
>IRQ number hacks for AM35x in this code.

This can be done. I will be posting the patch for AM35x hwmod also.

>
>Separating out the pdata function pointer hooks is a different matter
>which is also ugly, but I don't feel as strongly about.

I have another patch to move all the board specific internal PHY functions
to another file and pass them through board data instead of defining
and assigning here in the shared file.

Regards,
Hema
>
>Kevin
>
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
