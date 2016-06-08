From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 8 Jun 2016 15:04:02 +0300
Message-ID: <71cb45ec-a269-d510-df34-eb6eaa781da8@cogentembedded.com>
References: <201601091616.04193@pali> <3690314.8jDXSUDcRZ@saturn>
 <20160121192113.GM19432@atomide.com> <201601231357.32629@pali>
 <20160529103824.GM29844@pali> <20160607125044.GI29844@pali>
 <20160608095321.GH22406@atomide.com> <87h9d49exz.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h9d49exz.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 6/8/2016 1:02 PM, Felipe Balbi wrote:

>> * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160607 05:53]:
>>>> Tony, what do you think about that patch?
>>>>
>>>
>>> Tony, PING
>>
>> Yeah I don't know, AFAIK we don't have a generic way to
>> force MUSB to change mode without ID pin. If you have figured
>> something generic for that which does not actually tinker with
>> the PHY registers directly, that should be the generic
>> musb_set_mode() that we've been wondering about for years.
>
> #define MUSB_TEST_FORCE_HOST	0x80
>
> Can someone confirm on MUSB's docs (and actual running system) that t=
his
> does what's supposed to do?

    The MUSB programmer's guide says the CID (sic) input is ignored whe=
n the=20
=46orce_Host bit is set. The host mode is entered when the Session bit =
is set.
But I don't have a MUSB hardware readily available to confirm.

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
