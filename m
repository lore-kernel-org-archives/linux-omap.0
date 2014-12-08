From: Nishanth Menon <nm@ti.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Mon, 8 Dec 2014 07:54:08 -0600
Message-ID: <5485AD80.1050008@ti.com>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com> <20141205162312.GB11502@n2100.arm.linux.org.uk> <CA+Ln22EFKRm_9HPaVvL7zFdmmB5Zz5RnJKbZkESVOBOLPvUnGA@mail.gmail.com> <20141208122235.GC11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141208122235.GC11502@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-omap <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/08/2014 06:22 AM, Russell King - ARM Linux wrote:
> On Mon, Dec 08, 2014 at 08:54:18PM +0900, Tomasz Figa wrote:
>> 2014-12-06 1:23 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>> Given where we are in the cycle (-final likely this weekend) the only
>>> thing we can do right now is to drop the patch set; exynos (and mvebu)
>>> will have to wait another cycle until this patch set (hopefully in a
>>> revised form) can be merged.
>>
>> Or a fix could be queued on top of this. Since (I believe) this series
>> has been queued for 3.19, we have 6 or 7 RC releases ahead, which
>> could be used for the purpose of fixing things (as they are supposed
>> to?).
> 
> They were merged on 27th November, so they would've been in linux-next
> from about last Monday.  Nishanth reported a failure on Friday, the

For what ever it is worth, the l2c changes actually appeared on
Thursday CST (next-20141204). Found the regression against
next-20141203 tag and it took me a day to track it down (after looking
at a few other regressions as well)..

Anyways...

-- 
Regards,
Nishanth Menon
