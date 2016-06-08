From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 8 Jun 2016 15:32:24 +0300
Message-ID: <36fb7207-41ed-5ea5-f6f3-d1dd1552bfaa@cogentembedded.com>
References: <201601091616.04193@pali> <87h9d49exz.fsf@linux.intel.com>
 <71cb45ec-a269-d510-df34-eb6eaa781da8@cogentembedded.com>
 <17243006.AtPKaaqTIG@saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17243006.AtPKaaqTIG@saturn>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 6/8/2016 3:18 PM, joerg Reisenweber wrote:

>>>>>> Tony, what do you think about that patch?
>>>>>
>>>>> Tony, PING
>>>>
>>>> Yeah I don't know, AFAIK we don't have a generic way to
>>>> force MUSB to change mode without ID pin. If you have figured
>>>> something generic for that which does not actually tinker with
>>>> the PHY registers directly, that should be the generic
>>>> musb_set_mode() that we've been wondering about for years.
>>>
>>> #define MUSB_TEST_FORCE_HOST	0x80
>>>
>>> Can someone confirm on MUSB's docs (and actual running system) that this
>>> does what's supposed to do?
>>
>>     The MUSB programmer's guide says the CID (sic) input is ignored when the
>> Force_Host bit is set. The host mode is entered when the Session bit is
>> set. But I don't have a MUSB hardware readily available to confirm.
>>
>> MBR, Sergei
>
> also says:
>
> While the FORCE_HOST bit remains set, the core will enter Host mode when the
> Session bit is set and **remain in Host mode until the Session bit is cleared
> even if a connected device is disconnected during the session.**
> The operating speed while in this mode **is determined for the setting of the
> FORCE_HS and FORCE_FS bits of the Testmode register** in Section 23.1.4.11.

    Yeah, the MUSB PG says the same.

[...]

> /j

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
