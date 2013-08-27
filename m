From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v5] gpio: pcf857x: Add OF support
Date: Tue, 27 Aug 2013 14:00:24 +0530
Message-ID: <521C63A0.10902@ti.com>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2063335.Uqxok8bYMn@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2063335.Uqxok8bYMn@flatron>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 27 August 2013 01:44 PM, Tomasz Figa wrote:
> Hi Laurent,
>
> On Tuesday 27 of August 2013 10:02:39 Laurent Pinchart wrote:
>> Add DT bindings for the pcf857x-compatible chips and parse the device
>> tree node in the driver.
>>
>> Signed-off-by: Laurent Pinchart
>> <laurent.pinchart+renesas@ideasonboard.com> ---
>>   .../devicetree/bindings/gpio/gpio-pcf857x.txt      | 71
>> ++++++++++++++++++++++ drivers/gpio/gpio-pcf857x.c
>>    | 44 +++++++++++--- 2 files changed, 107 insertions(+), 8
>> deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/gpio/gpio-pcf857x.txt
>>
>> Changes since v4:
>>
>> - Don't try to get ngpio from of_device_id data, we already get it from
>>    i2c_device_id
>
> Hmm, I'm not sure how this is supposed to work.
>
> How does the I2C core resolve OF compatible name to particular entry in
> id_table? I believe it simply passes NULL as the second argument of
> .probe() if the device is instantiated based on OF compatible string and
> not one in the legacy ID table.

It doesn't pass the second argument as NULL. If you look at 
i2c_device_probe() in drivers/i2c/i2c-core.c, the second argument to 
probe is passed as: i2c_match_id(driver->id_table, client)

This will extract the i2c_device_id pointer from the id_table.

Archit
