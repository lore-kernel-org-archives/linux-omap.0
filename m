From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] clk: Support for Palmas clk32kg and clk32kgaudio
 clocks
Date: Mon, 26 May 2014 10:06:39 +0300
Message-ID: <5382E7FF.7070600@ti.com>
References: <1399382685-14781-1-git-send-email-peter.ujfalusi@ti.com> <20140506133136.GA11626@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140506133136.GA11626@kahuna>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: mturquette@linaro.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ldewangan@nvidia.com, linux-doc@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

Mike,

On 05/06/2014 04:31 PM, Nishanth Menon wrote:
> On 16:24-20140506, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v1:
>> - binding documentation and driver has been separated based on Nisha=
nth Menon's
>>   comment

Could you take a look at this series please? I really hoped that it wou=
ld make
it to 3.16...

Thanks,
P=E9ter

>>
>> v1 of the driver can be found:
>> https://lkml.org/lkml/2014/4/3/104
>>
>> Palmas class of devices can provide 32K clock(s) to be used by other=
 devices
>> on the board. Depending on the actual device the provided clocks can=
 be:
>> CLK32K_KG and CLK32K_KGAUDIO
>> or only one:
>> CLK32K_KG (TPS659039 for example)
>>
>> Use separate compatible flags for the two 32K clock.
>> A system which needs or have only one of the 32k clock from
>> Palmas will need to add node(s) for each clock as separate section
>> in the dts file.
>> The two compatible property is:
>> "ti,palmas-clk32kg" for clk32kg clock
>> "ti,palmas-clk32kgaudio" for clk32kgaudio clock
>>
>> Apart from the register control of the clocks - which is done via
>> the clock API there is a posibility to enable the external sleep
>> control. In this way the clock can be enabled/disabled on demand by =
the
>> user of the clock.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (2):
>>   dt/bindings: Binding documentation for Palmas clk32kg and clk32kga=
udio
>>     clocks
>>   clk: Add driver for Palmas clk32kg and clk32kgaudio clocks
>>
>>  .../bindings/clock/clk-palmas-clk32kg-clocks.txt   |  35 +++
>>  drivers/clk/Kconfig                                |   7 +
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/clk-palmas.c                           | 307 ++++++++++=
+++++++++++
>>  include/dt-bindings/mfd/palmas.h                   |  18 ++
>>  5 files changed, 368 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/clk-palm=
as-clk32kg-clocks.txt
>>  create mode 100644 drivers/clk/clk-palmas.c
>>  create mode 100644 include/dt-bindings/mfd/palmas.h
>>
>> --=20
>> 1.9.2
>>
>=20
> Series:
> Reviewed-by: Nishanth Menon <nm@ti.com>


