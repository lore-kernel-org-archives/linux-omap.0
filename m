From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Tue, 05 Jul 2011 12:41:24 +0530
Message-ID: <4E12B91C.8020102@ti.com>
References: <1309327221-4121-1-git-send-email-shubhrajyoti@ti.com>	<871uycql0y.fsf@ti.com> <4E0C24A5.5020905@ti.com> <874o37djdg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874o37djdg.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 01 July 2011 04:20 AM, Kevin Hilman wrote:
> Shubhrajyoti<shubhrajyoti-l0cyMroinI0@public.gmane.org>  writes:
>
>> On Thursday 30 June 2011 04:53 AM, Kevin Hilman wrote:
>>> Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>   writes:
>>>
>>>> Currently the fifo depth is set to zero for OMAP4 which disables
>>>> the FIFO usage. This patch enables the FIFO usage for I2C transact=
ions
>>>> on OMAP4 also.
>>> Do you know the history of why the FIFO depth was set to zero?  A
>>> summary of that history would greatly help reviewers.
Looks like it is disabled in the initial bring up and some how didn=92t=
=20
get enabled.
All I could find is
http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg01404.html

>>>> Reported-By:Nishanth Menon<nm-l0cyMroinI0@public.gmane.org>
>>> minor: missing space after ':'
Yes will fix it.
>>>> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>> Tested on what platforms?   OMAP3 also?
>> OMAP4 and OMAP3
> Please add a brief summary of what platforms it was tested on in the
> changelog.
Will update it
>>> Could you please rebase this onto my for_3.1/i2c-andy branch[1] whe=
re we
>>> have a large series of I2C patches queued up for the v3.1 merge win=
dow
>>> already?
>> OK will rebase and resend.
Sent a rebased version.
> Thanks,
>
> Kevin
