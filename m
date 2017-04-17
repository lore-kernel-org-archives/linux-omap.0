From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: add bluetooth
Date: Mon, 17 Apr 2017 07:51:18 -0500
Message-ID: <CAL_JsqLkGXN3hjocJ3-X8f7e0Az28-LeXNpMwnSeUwGtG5m4Hg@mail.gmail.com>
References: <20170415221832.16175-1-sre@kernel.org> <CAEz3QY0duPa91TT3e86xA=tDGppiq0UXmDzuUm2i6cXbBi9CgQ@mail.gmail.com>
 <20170416152650.5376wwhhdcbpdba5@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170416152650.5376wwhhdcbpdba5@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Michael Scott <michael.scott@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 16, 2017 at 10:26 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Michael,
>
> On Sat, Apr 15, 2017 at 07:00:29PM -0700, Michael Scott wrote:
>> On Apr 15, 2017 3:18 PM, "Sebastian Reichel" <sre@kernel.org> wrote:
>>> Droid 4 has wl1835 connected to the OMAP's UART4 port, which is
>>
>> Technically, I believe the Droid 4 has WL1283 WLAN chip.
>>
>> - Mike
>
> iFixit [0] has a nice photo in step 15, which clearly shows,
> that its a WL1285C, with 1835 looking similar I didn't notice
> Rob's binding does not cover wl128x. I will resend with proper
> compatible value (+ patches for the driver and binding).

I only documented what was publicly available as some parts have
failed to materialize. Any idea what the differences are?

Rob
