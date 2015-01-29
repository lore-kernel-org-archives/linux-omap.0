From: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Supporting two SMSC9221 interfaces on GPMC in a dts
Date: Thu, 29 Jan 2015 14:23:29 -0800
Message-ID: <CAK8F28kt90RsHxJwJdSt0-0t2Dfi3-D95zqFmTZoAjYt=NrgXA@mail.gmail.com>
References: <CAK8F28=sANBtwDdg45MuVmrE89SBYtzBsZcPZoXo=AhOv0wpOg@mail.gmail.com>
 <20150129162020.GA16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150129162020.GA16250-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 29, 2015 at 8:20 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Yeah I think this is how we did it for omap3-sbc-*.dts*.
>
>> This works but seems, well, verbose.  Is there a way to setup multiple
>> interfaces without having to duplicate the omap-gpmc-smsc9221.dtsi
>> content?
>
> Hmm I wonder if the "[PATCH] dtc: parser: Add label while overriding
> nodes" would help with this too?
>
> I agree it would be nice to be able to have device specific .dtsi
> file that can be included multiple times for the most common devices.
Thanks Tony.

For now, I'll follow the lead of omap3-sbc-*.dts* for now in lieu of
another technique suggestion.  The "[PATCH] dtc: parser: Add label
while overriding nodes" patch definitely looks promising so I'll watch
for that landing in hopes of testing it for this case.

--Ash
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
