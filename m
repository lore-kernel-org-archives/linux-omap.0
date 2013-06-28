From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v9 1/8] drivers: phy: add generic PHY framework
Date: Fri, 28 Jun 2013 10:45:58 +0530
Message-ID: <51CD1C0E.5030000@ti.com>
References: <000d01ce73af$62a95a60$27fc0f20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <000d01ce73af$62a95a60$27fc0f20$@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, 'Rob Landley' <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, 'Benoit Cousson' <benoit.cousson@linaro.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, 'Cesar Eduardo Barros' <cesarb@cesarb.net>, "David S. Miller" <davem@davemloft.net>, 'Rajendra Nayak' <rnayak@ti.com>, Shawn Guo <shawn.guo@linaro.org>, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>, 'George Cherian'
List-Id: linux-omap@vger.kernel.org

On Friday 28 June 2013 08:57 AM, Jingoo Han wrote:
> On Wed, 26 Jun 2013 17:17:29 +0530, Kishon Vijay Abraham Iwrote:
>> The PHY framework provides a set of APIs for the PHY drivers to
>> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
>> PHY with or without using phandle. For dt-boot, the PHY drivers should
>> also register *PHY provider* with the framework.
>>
>> PHY drivers should create the PHY by passing id and ops like init, exit,
>> power_on and power_off. This framework is also pm runtime enabled.
>>
>> The documentation for the generic PHY framework is added in
>> Documentation/phy.txt and the documentation for dt binding can be found at
>> Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Tested-by: Jingoo Han <jg1.han@samsung.com>
>
> It looks great to me!
>
> I tested this General PHY framework with Exynos5250 eDP.
> It works properly.

Thanks for testing this :-)

> I will share the patch 'Generic PHY driver for the Exynos SoC DP PHY', soon.
> Thanks.

Cool.

Thanks
Kishon
