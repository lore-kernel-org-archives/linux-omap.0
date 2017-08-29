From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for omap4
Date: Tue, 29 Aug 2017 10:31:32 -0500
Message-ID: <CAHCN7xK7Vy8Hw1OV3AQb4vAo3n=6qfE_8xunL1MXQaTLY0Yy4w@mail.gmail.com>
References: <20170828211918.11573-1-tony@atomide.com> <20170828211918.11573-15-tony@atomide.com>
 <20170829090034.ytepjfv2jkkd2b3z@earth> <20170829144205.GX6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170829144205.GX6008-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 29, 2017 at 9:42 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170829 02:01]:
>> Hi,
>>
>> On Mon, Aug 28, 2017 at 02:19:15PM -0700, Tony Lindgren wrote:
>> > On omap4 we're missing the PowerVR SGX GPU node with it's related
>> > "ti,hwmods" property that the SoC interconnect code needs.
>> >
>> > Note that this will only show up as a bug with "doesn't have
>> > mpu register target base" boot errors when the legacy platform
>> > data is removed.
>>
>> I think OMAP3 & OMAP5 should also be documented and getting a
>> node in this series?
>
> Looks like we don't currently have any interconnect data defined
> for those, but yeah sure I can add those.
>

If there is anything I can test, I had modified the SGX driver for the
OMAP36, but abandoned my attempts since much of the device tree and
reset stuff was missing.  I'd love to see SGX work again.  :-)

adam

> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
