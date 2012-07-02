From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] remoteproc: maintain a generic child device for each
 rproc
Date: Mon, 02 Jul 2012 12:06:45 -0700
Message-ID: <4FF1F145.2050408@codeaurora.org>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com> <4FC5DBFA.2030300@codeaurora.org> <CAK=WgbZJJJPuNWVv8WgL=KKm6Hrx2krDD9gBOTP7sA8p7mh_rA@mail.gmail.com> <CAK=WgbbREXV8nkF4vh9iLUp1WQj2ZLYW6VG8Urmw9=roy63meQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbREXV8nkF4vh9iLUp1WQj2ZLYW6VG8Urmw9=roy63meQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/29/12 01:13, Ohad Ben-Cohen wrote:
> On Wed, May 30, 2012 at 3:16 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> In this case, I was more wondering between using a class to a device type.
>>
>>> I recall seeing a thread where
>>> someone said classes were on the way out and shouldn't be used but I
>>> can't find it anymore.
>> I also remembered a similar discussion at a plumbers mini-conf about
>> 2-3 years ago too, so I looked at device_type as an alternative to
>> class. The former looks somewhat simpler, but I couldn't find any
>> major advantage for using one over the other, and both seem to be in
>> use by many subsystems.
> Moving to device_type is so trivial that I gave it a spin (and moved
> to IDA too while at it):

Great! It looks like device_type doesn't have any list iteration support
though. Is that requirement gone? If that requirement is still there I
would think we need something like a class or bus still.

Will you resend this as part of a series? It will be easier to review then.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
