From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v5] gpio: pcf857x: Add OF support
Date: Tue, 27 Aug 2013 13:55 +0200
Message-ID: <1830640.BeoA2uHWDI@amdc1227>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2063335.Uqxok8bYMn@flatron> <521C63A0.10902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <521C63A0.10902@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Archit Taneja <archit@ti.com>, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, grant.likely@secretlab.ca
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 of August 2013 14:00:24 Archit Taneja wrote:
> Hi,
> 
> On Tuesday 27 August 2013 01:44 PM, Tomasz Figa wrote:
> > Hi Laurent,
> > 
> > On Tuesday 27 of August 2013 10:02:39 Laurent Pinchart wrote:
> >> Add DT bindings for the pcf857x-compatible chips and parse the device
> >> tree node in the driver.
> >> 
> >> Signed-off-by: Laurent Pinchart
> >> <laurent.pinchart+renesas@ideasonboard.com> ---
> >> 
> >>   .../devicetree/bindings/gpio/gpio-pcf857x.txt      | 71
> >> 
> >> ++++++++++++++++++++++ drivers/gpio/gpio-pcf857x.c
> >> 
> >>    | 44 +++++++++++--- 2 files changed, 107 insertions(+), 8
> >> 
> >> deletions(-)
> >> 
> >>   create mode 100644
> >> 
> >> Documentation/devicetree/bindings/gpio/gpio-pcf857x.txt
> >> 
> >> Changes since v4:
> >> 
> >> - Don't try to get ngpio from of_device_id data, we already get it
> >> from
> >> 
> >>    i2c_device_id
> > 
> > Hmm, I'm not sure how this is supposed to work.
> > 
> > How does the I2C core resolve OF compatible name to particular entry in
> > id_table? I believe it simply passes NULL as the second argument of
> > .probe() if the device is instantiated based on OF compatible string
> > and
> > not one in the legacy ID table.
> 
> It doesn't pass the second argument as NULL. If you look at
> i2c_device_probe() in drivers/i2c/i2c-core.c, the second argument to
> probe is passed as: i2c_match_id(driver->id_table, client)
> 
> This will extract the i2c_device_id pointer from the id_table.

Yes, there is a chance that it will not return NULL, but I think that 
relying on this is rather flawed.

If you look at the whole code path, you can see that it's only a 
coincidence that this works. See the execution flow:
 - I2C adapter driver calls of_i2c_register_devices(),
 - of_i2c_register_devices() calls of_modalias_node() for every device on 
this bus,
 - of_modalias_node() stores the second substring of compatible string 
separated by a comma, if there is one or the whole compatible otherwise to 
the output buffer (type field of i2c_board_info struct, as passed by 
of_i2c_register_devices()),
 - of_i2c_register_devices() then calls i2c_new_device() with the resulting 
info struct,
 - i2c_new_device() takes info->type and copies its contents to client-
>name,
 - then a bit later, I2C core calls i2c_match_id(), which does matching of 
client->name against id_table of the driver and the resulting i2c_device_id 
entry (or NULL) is then passed to driver's .probe() callback.

So if it happens that compatible is not equal to "<vendor>,<ID from legacy 
I2C table>", then the matching will fail and NULL will be passed.

[CCing Wolfram and Grant, as they should now more about this behavior and 
whether it's intentional or no]

Best regards,
Tomasz
