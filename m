From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 06/10] I2C: OMAP: Fix the crash in i2c remove
Date: Thu, 26 Apr 2012 11:58:19 +0530
Message-ID: <4F98EB03.8060903@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com> <1334842101-20670-7-git-send-email-shubhrajyoti@ti.com> <20120423164944.GE27321@pengutronix.de> <4F96ED77.9070503@ti.com> <20120424181806.GF9007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120424181806.GF9007-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 April 2012 11:48 PM, Wolfram Sang wrote:
> On Tue, Apr 24, 2012 at 11:44:15PM +0530, Shubhrajyoti wrote:
>> On Monday 23 April 2012 10:19 PM, Wolfram Sang wrote:
>>>>     [  154.901153] Exception stack(0xdf9b9fb0 to 0xdf9b9ff8)
>>>>>     [  154.907104] 9fa0:                                     beaf=
1f04 4006be00 0000000f 0000000c
>>>>>     [  154.915710] 9fc0: 4006c000 00000000 00008034 ffffff40 0000=
0007 00000000 00000000 0007b8d7
>>>>>     [  154.916778] 9fe0: 00000000 beaf1b68 0000d23c 4005baf0 8000=
0010 ffffffff
>>>>>     [  154.931335]  r6:ffffffff r5:80000010 r4:4005baf0 r3:beaf1f=
04
>>>>>     [  154.937316] ---[ end trace 1b75b31a2719ed21 ]--
>>>>>
>>>>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>> Is this really the correct solution? I do wonder that every driver =
using
>>> runtime PM should enable the clocks on their own. That should be do=
ne by
>>> the core,=20
>> By core you don't mean the i2c core but the pm layer right?
> Yes.
>
>>> I'd say; it is not unusual that drivers need to write to
>>> registers in remove(). If it is correct, can I get some acks?
>> I did see the crash.
> That was never a doubt. With "correct" I meant "correct solution".
>
>> Will wait for the pm experts to comment.

As far as I know I don=92t think that the pm layer doesn't enable the c=
locks
for the drivers on remove. Maybe Kevin or Rajendra can comment better.
