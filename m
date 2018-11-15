From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
Date: Thu, 15 Nov 2018 10:16:53 +0900
Message-ID: <5BECC905.4060802@samsung.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
        <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
        <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com>
        <5BEBEF7C.7060003@samsung.com>
        <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
        <5BEC018E.8020102@samsung.com>
        <CAHp75Vc3NC95Wt9T2qx9SCGtwoR2hA7azGAHhqz7LO-yKz=mew@mail.gmail.com>
        <CAHp75VduXH0OKcD2AyR03eNrWW8bKGL-ijfQocfQ+MDCAq0yag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAHp75VduXH0OKcD2AyR03eNrWW8bKGL-ijfQocfQ+MDCAq0yag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

On 2018년 11월 14일 23:04, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 1:17 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Nov 14, 2018 at 1:05 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>>>> Changing NULL to -ENODEV is a trading bad to worse.
> 
>> P.S. I still disagree with your arguments in relation to de facto use of an API.
> 
> I spoke to colleagues of mine and they are agree that semantically
> -EPROBE_DEFER is a wrong error code from API that matches against some
> list.
> On the other hand, they agree with me that changing NULL to -ENODEV is
> a trading bad to worse.
> 
> So, I withdraw mine complaints against API.
> 

OK. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
