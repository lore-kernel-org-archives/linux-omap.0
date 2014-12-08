From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Mon, 8 Dec 2014 20:54:18 +0900
Message-ID: <CA+Ln22EFKRm_9HPaVvL7zFdmmB5Zz5RnJKbZkESVOBOLPvUnGA@mail.gmail.com>
References: <5481D913.9040109@ti.com>
	<5481D9BF.2090007@ti.com>
	<20141205162312.GB11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141205162312.GB11502@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-omap <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

2014-12-06 1:23 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Dec 05, 2014 at 10:13:51AM -0600, Nishanth Menon wrote:
>> On 12/05/2014 10:10 AM, Nishanth Menon wrote:
>> > Case #2: Reverting the following allows boot.
>> >
>> > From next-20141204
>> > 10df7d5 ARM: 8211/1: l2c: Add support for overriding prefetch settings
>> > revert this  -> boot still fails
>> >
>> > d42ced0 ARM: 8210/1: l2c: Get outer cache .write_sec callback from
>> > mach_desc only if not NULL
>> > revert this  -> boot still fails
>> >
>> > 46b9af8 ARM: 8209/1: l2c: Add interface to ask hypervisor to configure L2C
>> > revert this  -> boot still fails
>> >
>> > c94e325 ARM: 8208/1: l2c: Refactor the driver to use commit-like
>> > revert this  -> boot passed (first bad commit).
>> >
>> >
>>
>> + linux-samsung soc and updated Thomaz's mail ID (gmail now).
>
> Given where we are in the cycle (-final likely this weekend) the only
> thing we can do right now is to drop the patch set; exynos (and mvebu)
> will have to wait another cycle until this patch set (hopefully in a
> revised form) can be merged.

Or a fix could be queued on top of this. Since (I believe) this series
has been queued for 3.19, we have 6 or 7 RC releases ahead, which
could be used for the purpose of fixing things (as they are supposed
to?).

>
> I think we need 8208/1 split up into smaller changes so that the cause
> of this regression can be found.

I'm afraid we need more than that.

First of all, this series has been in the wild for more than 3 months
already, without any serious changes. Need not to mention that mailing
lists and maintainers of all potentially affected platforms had been
added. It had been noted in cover letter that the only platform I (and
Marek later) could test on was Exynos and that it would be good if
somebody working with other platforms could test the patches.

Looks like nobody cared back then, so why should we care that much
now, especially that we have several RC releases ahead and we can
still fix this?

Best regards,
Tomasz
