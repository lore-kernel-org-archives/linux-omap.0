From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 17:39:03 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E29B@dbde02.ent.ti.com>
References: <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
 <20100924084344.GJ8365@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E0DC@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E128@dbde02.ent.ti.com>
 <20100924105646.GT8365@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E212@dbde02.ent.ti.com>
 <20100924110433.GW8365@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100924110433.GW8365-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Friday, September 24, 2010 4:35 PM
>To: Kalliguddi, Hema
>Cc: Balbi, Felipe; Kevin Hilman; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Basak, Partha; Tony Lindgren; 
>Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
>Hi,
>
>On Fri, Sep 24, 2010 at 06:00:26AM -0500, Kalliguddi, Hema wrote:
>>then for now I can think of using set_clok platform function to call
>>the runtime pm apis, Is there any alternative you are thinking of?
>
>how about not pushing a patch which isn't the best way to solve the
>problem in the first place ? .38 isn't that far away. If we can get all
>those cleanups by that time, converting to pm_runtime will be a lot
>simpler and local change.
>
>I mean, if we keep as is for another major release cycle, it 
>won't cause
>problems to anyone, right ? So it's better to get things right from the
>beginning and avoid lots of re-work later.
>
Agreed that it is better to get the things done in the best way from the beginning.
This may not be the best solution for converting usb to use runtime pm apis, but given the current mainline
code, without the cleanup, do not have other alternatives.
Do you think the other patches are in good shape to merge after fixing the comments
I got from Kevin and Benoit and you? 

Kevin,

Do you have any other comments on the hwmod patches other than runtime pm patch and offmode patch?
Do you accept the hwmod patches without the runtime pm conversion?

>-- 
>balbi
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
