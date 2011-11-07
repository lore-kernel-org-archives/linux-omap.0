From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 1/4] regulator: helper routine to extract regulator_init_data
Date: Mon, 07 Nov 2011 11:53:36 +0530
Message-ID: <4EB77968.803@ti.com>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com> <20111104202905.GA3918@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104202905.GA3918@quad.lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Olof,

On Saturday 05 November 2011 01:59 AM, Olof Johansson wrote:
>> +- regulator-min-uV: smallest voltage consumers may set
>> >  +- regulator-max-uV: largest voltage consumers may set
>> >  +- regulator-uV-offset: Offset applied to voltages to compensate for voltage drops
>> >  +- regulator-min-uA: smallest current consumers may set
>> >  +- regulator-max-uA: largest current consumers may set
>> >  +- regulator-always-on: boolean, regulator should never be disabled
>> >  +- regulator-boot-on: bootloader/firmware enabled regulator
 >
> Once you have a compatible field that can determine what kind of device node,
> and binding, this is, you can drop the regulator- prefix and save some space in
> the device tree. Properties are rarely prefixed by their subsystem. Only
> exception would/could be the regulator-name property where it could make
> sense to keep the prefix.

given that we decided not to have a compatible field like "regulator"
for the top-level bindings and instead have a device specific one,
and based on the discussions with Grant here[1], I hope its OK to keep
these the way they are.

regards,
Rajendra

[1] 
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-September/008196.html
