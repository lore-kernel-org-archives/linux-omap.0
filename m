From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v3.11-rc1 USB regressions
Date: Thu, 25 Jul 2013 11:08:03 +0200
Message-ID: <51F0EAF3.1060606@gmail.com>
References: <20130715225647.GE3296@blackmetal.musicnaut.iki.fi> <51E4E922.2040707@gmail.com> <20130716175710.GA14385@blackmetal.musicnaut.iki.fi> <20130724185119.GB26943@blackmetal.musicnaut.iki.fi> <51F0253C.7090205@gmail.com> <20130725003029.GD26943@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130725003029.GD26943-R3WNPi76c83LsdW6vOPryG4HOFkwEHDbMR2xtNvyitY@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 25.07.2013 02:30, Aaro Koskinen wrote:
> On Wed, Jul 24, 2013 at 09:04:28PM +0200, Daniel Mack wrote:
>> On 24.07.2013 20:51, Aaro Koskinen wrote:
>>>> When I revert fe4cb0912f8e737f8e4b8b38b9e692f8062f5423 and
>>>> 8b125df5b24cfb0ec7fa1971e343cc0badc1827d, it works like before (3.10):
>>>
>>> I'm now running -rc2 with above fixes and reverts (the only way to get
>>> USB working). I'm seeing an additional issue, the following crash happens
>>> always on N900 when doing "poweroff":
>>
>> Yes, with the mentioned patches reverted, musb_to_hcd() will return a
>> faulty pointer. You can't easily revert them unfortunately.
>>
>> Your platform needs a real fix, I just have trouble understanding why a
>> removed usb_add_hcd() would make the gadget code fail.
>>
>> Sorry for the trouble, but I don't currently have a board with musb in
>> gadget mode to reproduce this issue.
> 
> If you have any ideas what to look for, I can maybe try to debug this
> issue.

Please try changing the .mode field of musb_board_data to MUSB_OTG in
your board file (arch/arm/mach-omap2/board-rx51.c). That should bring
back the call to usb_add_hcd(), provided that you have USB_MUSB_DUAL_ROLE=y.

I still don't see a reason why this is should be necessary for
peripheral-only use though.


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
