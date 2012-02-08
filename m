From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: fix build breakage when CONFIG_OF is not set
Date: Wed, 8 Feb 2012 16:42:56 +0530
Message-ID: <CAM=Q2cvZWdUk-v4-EWUJzAf4br-4+tO2s3qS_dn4KhHp+mm2+g@mail.gmail.com>
References: <1328698612-18661-1-git-send-email-coelho@ti.com>
	<20120208105957.GB16334@legolas.emea.dhcp.ti.com>
	<1328699077.20197.51.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328699077.20197.51.camel@cumari>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 8, 2012 at 4:34 PM, Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, 2012-02-08 at 12:59 +0200, Felipe Balbi wrote:
>> On Wed, Feb 08, 2012 at 12:56:52PM +0200, Luciano Coelho wrote:
>> > Since commit 6145197be6cc0583fa1a2f4ec1079d366137061e, building
>>
>> we generally like to see the commit subject here too. And adding the
>> abbreviated commit instead of the full sha1, wouldn't hurt either ;-=
)
>
> Ok, different practices. :)

However  there was already a discurssion.
Anyways thanks for the patch.
http://permalink.gmane.org/gmane.linux.ports.arm.omap/69796


>
> I'll send v2.
I think there was already a fix for this.

http://www.spinics.net/lists/linux-omap/msg63151.html

Anyways thanks for the patch.

>
>
>> > i2c_omap.c breaks if CONFIG_OF is not set:
>> >
>> > drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
>> > drivers/i2c/busses/i2c-omap.c:1021: error: 'omap_i2c_of_match' und=
eclared (first use in this function)
>> > drivers/i2c/busses/i2c-omap.c:1021: error: (Each undeclared identi=
fier is reported only once
>> > drivers/i2c/busses/i2c-omap.c:1021: error: for each function it ap=
pears in.)
>> >
>> > This is because the definition of omap_i2c_of_match is #ifdef'd on
>> > CONFIG_OF, but the usage of it is not.
>> >
>> > Since the places where omap_ic2_of_match are prepared to get NULL
>> > pointers if CONFIG_OF is not defined, we can simply define it to N=
ULL.
>> >
>> > Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>> > Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
>>
>> after fixing the commit log, you can add:
>>
>> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>
>> if you want.
>
> Thanks for your quick review!
>
> --
> Cheers,
> Luca.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
