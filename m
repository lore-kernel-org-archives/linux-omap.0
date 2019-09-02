From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
Date: Mon, 2 Sep 2019 09:17:40 -0500
Message-ID: <68ce4c1a-5098-f6b8-e318-1d86d91a3206@lechnology.com>
References: <20190901225827.12301-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 9/1/19 5:58 PM, David Lechner wrote:
> This series adds device tree bindings and a new counter driver for the Texas
> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> 

...

> David Lechner (6):
>    bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
>    dt-bindings: counter: new bindings for TI eQEP
>    counter: new TI eQEP driver
>    ARM: dts: am33xx: Add nodes for eQEP
>    ARM: dts: am335x-boneblue: Enable eQEP
>    ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi
> 

In case anyone notices, this series only has 5 patches, not 6. "ARM: dts:
am335x-boneblue: Use of am335x-osd335x-common.dtsi" is unrelated and was
submitted separately.
