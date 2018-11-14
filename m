From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
Date: Wed, 14 Nov 2018 18:13:37 +0900
Message-ID: <5BEBE741.6050101@samsung.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
        <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

On 2018년 11월 14일 17:35, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>> I was thinking about again to change from NULL to EPROBE_DEFER.
>>
>> extcon_get_extcon_dev() function was almost called in the probe function.
>> But, this function might be called on other position instead of probe.
> 
> *Might be* sounds like a theoretical thing, care to share what is in you mind?
> Current users and more important the new coming one are *all* doing the same.
> 
>> ENODEV is more correct error instead of EPROBE_DEFER.
> 
> So, you are proposing to continue duplicating conversion from ENODEV
> to EPROBE_DEFER in *each* caller?

The extcon core don't know the caller situation is in either probe() or other position
in the caller driver. The caller driver should decide the kind of error value
by using the return value of extcon_get_extcon_dev().

extcon_get_extcon_dev() function cannot be modified for only one case.
If some device driver call extcon_get_extcon_dev() out of probe() fuction,
EPROBE_DEFER is not always correct.

> 
>> Sorry. I'll withdraw my opinion related acked-by tag until we are clarifying it.
> 
> I honestly don't know what to clarify here.
> 
> When we would have a real case we can change API correspondingly.
> For now, the score is 5:0 with use cases in practice.
> 
>> On 2018년 11월 12일 09:24, Chanwoo Choi wrote:
>>> On 2018년 11월 11일 03:10, Andy Shevchenko wrote:
>>>> All current users of extcon_get_extcon_dev() API considers
>>>> an extcon device a mandatory to appear. Thus, they all convert
>>>> NULL pointer to -EPROBE_DEFER error code.
>>>>
>>>> There is one more caller anticipated with the same requirements.
>>>>
>>>> To decrease a code duplication and a burden to the callers,
>>>> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
