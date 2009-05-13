From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] I2C:Moving Register Defines to Header File
Date: Wed, 13 May 2009 06:23:00 -0700
Message-ID: <87octx9lxn.fsf@deeprootsystems.com>
References: <52671.192.168.10.89.1242133785.squirrel@dbdmail.itg.ti.com>
	<87hbzqe55y.fsf@deeprootsystems.com>
	<57428.192.168.10.89.1242203177.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57428.192.168.10.89.1242203177.squirrel-pJFUjGLopx31T2qfsofKZtBPR1lH4CV8@public.gmane.org> (Syed Rafiuddin's message of "Wed\, 13 May 2009 13\:56\:17 +0530 \(IST\)")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"Syed Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org> writes:

>> "Syed Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org> writes:
>>
>>> This patch creates i2c-omap.h header and moves register and bit definition
>>> macros to it from i2c-omap.c
>>
>> Please use the description to describe the motivation for the changes
>> and the problems it is addressing/fixing.
>>
>> In other words, you described what your patch does but not why.
>
> The intention of the patch is to have a separate header which will have omap3
> and omap4 related register definitions. As omap4 has different offset addresses
> with respect to omap3,adding omap4 related stuff in the same file will leave
> the file look ugly.

IMO, The regs do not need to move to a separate header unless they will
be used outside of i2c-omap.c.

Kevin
