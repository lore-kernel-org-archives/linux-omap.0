From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Mon, 12 Sep 2011 22:24:57 +0530
Message-ID: <CAJe_ZhcxEaHoj+6+mTKOk2Jz9KBeTP-M3c2VMn=S4Y-K6iegKw@mail.gmail.com>
References: <CAGsJ_4wXURUwbf-fcNOq1m5-NJ9+VMuDq+9OJpBjFZK4C_X3cw@mail.gmail.com>
	<CAGsJ_4xkUhbO+ZxBV61bsABH0uDD=Mve4bvOA0KMsEbSMaEDbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56139 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab1ILQy7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 12:54:59 -0400
Received: by wyh22 with SMTP id 22so3693610wyh.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 09:54:57 -0700 (PDT)
In-Reply-To: <CAGsJ_4xkUhbO+ZxBV61bsABH0uDD=Mve4bvOA0KMsEbSMaEDbQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dan.j.williams@intel.com, sundaram@ti.com, linus.walleij@linaro.org, vinod.koul@intel.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

On 12 September 2011 21:56, Barry Song <21cnbao@gmail.com> wrote:
>> Define a new api that could be used for doing fancy data transfers
>> like interleaved to contiguous copy and vice-versa.
>> Traditional SG_list based transfers tend to be very inefficient in
>> such cases as where the interleave and chunk are only a few bytes,
>> which call for a very condensed api to convey pattern of the transfe=
r.
>>
>> This api supports all 4 variants of scatter-gather and contiguous tr=
ansfer.
>> Besides, it could also represent common operations like
>> =A0 =A0 =A0 =A0device_prep_dma_{cyclic, memset, memcpy}
>> and maybe some more that I am not sure of.
>>
>> Of course, neither can this api help transfers that don't lend to DM=
A by
>> nature, i.e, scattered tiny read/writes with no periodic pattern.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>
> anyway, this API needs a real user to prove why it needs to exist.
>
> prima2 can be the 1st(?, 2nd if TI uses) user of this API. let's try
> to see what the driver will be with this api. Then we might figure ou=
t
> more about what it should be.
>
Did you discover any issue with the api?
Because only three days ago you said
{
Jassi, you might think my reply as an ACK to "[PATCH] DMAEngine:
Define generic transfer request api".
}

The api met your requirements easily not because I know them already,
but because I designed the api to be as generic as practically possible=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
