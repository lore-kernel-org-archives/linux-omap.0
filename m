From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v2 PATCH 1/3] dt: device tree bindings for DDR memories
Date: Tue, 20 Dec 2011 12:39:52 +0530
Message-ID: <4EF034C0.9070401@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<1324303533-17458-2-git-send-email-aneesh@ti.com> <CAOesGMjOybCbu1Bgxe0Te=XANVOqOPcaDOL_6c4=pVCxzu9ZnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38641 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047Ab1LTHKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 02:10:00 -0500
Received: by ggnh1 with SMTP id h1so4694685ggn.6
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 23:09:59 -0800 (PST)
In-Reply-To: <CAOesGMjOybCbu1Bgxe0Te=XANVOqOPcaDOL_6c4=pVCxzu9ZnA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi Olof,

On Monday 19 December 2011 10:22 PM, Olof Johansson wrote:
> Hi,
>
> Some comments below, but also a more general question: How much of
> this generic data makes sense to encode in the device tree? Final
> hardware configuration usually has to take into consideration board
> layout/signal delays, etc, and that's not part of this binding.

The JEDEC specifies base values for all timing parameters. But Vendors
can improve on these timings and provide better values. Using device
specific timing values therefore provides scope for optimization.

Everything that I have encoded here is needed by our driver to
re-configure our SDRAM controller during DVFS. In fact, I have not
listed all AC timing parameters in the spec in this binding, leaving
the rest for future users to add if they need them.

>
>
> On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V<aneesh@ti.com>  wrote:
>
>> diff --git a/Documentation/devicetree/bindings/ddr/ddr.txt b/Documentation/devicetree/bindings/ddr/ddr.txt
>> new file mode 100644
>> index 0000000..f15c4dd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ddr/ddr.txt
>> @@ -0,0 +1,114 @@
>> +* DDR SDRAM memories compliant to JEDEC specifications JESD209-2(LPDDR2)
>> +  or JESD79-3(DDR3).
>> +
>> +Required properties:
>> +- compatible : Should be one of - "jedec,ddr3", "jedec,lpddr2-nvm",
>> +  "jedec,lpddr2-s2", "jedec,lpddr2-s4"
>> +
>> +  "ti,jedec-ddr3" should be listed if the memory part is DDR3 type
>> +
>> +  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
>> +
>> +  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
>> +
>> +  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
>> +
>> +- density  : string representing the density of the device in terms of
>> +  Mb (mega bits). Following are the allowed values: "64Mb", "128Mb",
>> +  "256Mb", "512Mb", "1Gb", "2Gb", "4Gb", "8Gb", "16Gb", or "32Gb"
>
> No, please encode as a two-cell integer instead.

That is what I thought of doing initially. But I felt that "32Gb" is
more readable than 34359738368 or 33554432(if the unit is Mb).

>
>> +- io-width : string representing the io width: "x8", "x16" or "x32".
>
> No, encode as an integer.

Ok.

>
>> +
>> +Optional properties:
>> +
>> +The following optional properties represent the minimum value of some AC
>> +timing parameters of the DDR device in terms of number of clock cycles.
>> +These values shall be obtained from the device data-sheet.
>> +
>> +The suffix nCK indicates that the unit for these parameters is number
>> +of DDR clock cycles. Note: In LPDDR2 spec and data-sheets tCK is used
>> +inter-changeably for nCK. Both are equivalent in this context.
>
> Please use only lower characters in property names unless absolutely
> necessary, which this doesn't qualify as, in my opinion.

I have used the names "as is" from the spec. Thought that might be
useful when users extract data from the data-sheets in the future to
create dts for new devices.

>
> Also, can't these strings be shortened a bit? All of them have '-min'
> in common, and none of them seem to be very devicetree-like in their
> naming.

Most of these have a counter part in the timings node. That is we have
both "tCKESR-min-nCK" and "tCKESR-ps" albeit in different nodes.

>
> Finally, the "lpddr2" and "ddr3" properties could just be prefixed
> with "lpddr2,<propertyname>" instead.

Makes sense. But a given node will have data for only either of them,

not both and the compatible property will clearly mention what the data
is for. Would you still like to have the above scheme?

>
>> +
>> +- tRRD-min-nCK
>> +- tWTR-min-nCK
>> +- tXP-min-nCK
>> +- tRTP-min-nCK
>> +- tCKE-min-nCK
>> +- tRPab-min-nCK                /* LPDDR2 only */
>> +- tRCD-min-nCK         /* LPDDR2 only */
>> +- tWR-min-nCK          /* LPDDR2 only */
>> +- tRASmin-min-nCK      /* LPDDR2 only */
>> +- tCKESR-min-nCK       /* LPDDR2 only */
>> +- tFAW-min-nCK         /* LPDDR2 only */
>> +- tZQCS-min-nCK                /* DDR3 only */
>> +- tZQoper-min-nCK      /* DDR3 only */
>> +- tZQinit-min-nCK      /* DDR3 only */
>> +- tXS-min-nCK          /* DDR3 only */
>> +
>> +Child nodes:
>> +- The ddr node may have one or more child nodes of type "ddr-timings".
>> +  "ddr-timings" provides AC timing parameters of the device for
>> +  a given speed-bin. The user may provide the timings for as many
>> +  speed-bins as is required. Please see Documentation/devicetree/
>> +  bindings/ddr/ddr-timings.txt for more information on "ddr-timings"
>> +
>> +Example:
>> +
>> +elpida_ECB240ABACN : ddr {
>> +       compatible      = "Elpida,ECB240ABACN","jedec,lpddr2-s4";
>> +       density         = "2Gb";
>> +       io-width        = "x32";
>> +
>> +       tRPab-min-nCK   =<3>;
>> +       tRCD-min-nCK    =<3>;
>> +       tWR-min-nCK     =<3>;
>> +       tRASmin-min-nCK =<3>;
>> +       tRRD-min-nCK    =<2>;
>> +       tWTR-min-nCK    =<2>;
>> +       tXP-min-nCK     =<2>;
>> +       tRTP-min-nCK    =<2>;
>> +       tCKE-min-nCK    =<3>;
>> +       tCKESR-min-nCK  =<3>;
>> +       tFAW-min-nCK    =<8>;
>> +
>> +       timings_elpida_ECB240ABACN_400mhz: ddr-timings {
>
> You will need a unit address here.

Ok. ddr-timing@0, ddr-timings@1 etc, right?

>
>> +               min-freq        =<10000000>;
>> +               max-freq        =<400000000>;
>> +               tRP-ps          =<21000>;
>> +               tRCD-ps         =<18000>;
>> +               tWR-ps          =<15000>;
>> +               tRAS-min-ps     =<42000:;
>> +               tRRD-ps         =<10000>;
>> +               tWTR-ps         =<7500>;
>> +               tXP-ps          =<7500>;
>> +               tRTP-ps         =<7500>;
>> +               tCKESR-ps       =<15000>;
>> +               tDQSCK-max-ps   =<5500>;
>> +               tFAW-ps         =<50000>;
>> +               tZQCS-ps        =<90000>;
>> +               tZQoper-ps      =<360000>;
>> +               tZQinit-ps      =<1000000>;
>> +               tRAS-max-ns     =<70000>;
>> +       };
>> +
>> +       timings_elpida_ECB240ABACN_200mhz: ddr-timings {
>
> Same here, since you have more than one table. See previous
> discussions about emc tables on tegra (I'll repost that series this
> week).

Ok.

>
>> +               min-freq        =<10000000>;
>> +               max-freq        =<200000000>;
>> +               tRP-ps          =<21000>;
>> +               tRCD-ps         =<18000>;
>> +               tWR-ps          =<15000>;
>> +               tRAS-min-ps     =<42000:;
>
> Typo

Will fix.

>
>> +               tRRD-ps         =<10000>;
>> +               tWTR-ps         =<10000>;
>> +               tXP-ps          =<7500>;
>> +               tRTP-ps         =<7500>;
>> +               tCKESR-ps       =<15000>;
>> +               tDQSCK-max-ps   =<5500>;
>> +               tFAW-ps         =<50000>;
>> +               tZQCS-ps        =<90000>;
>> +               tZQoper-ps      =<360000>;
>> +               tZQinit-ps      =<1000000>;
>> +               tRAS-max-ns     =<70000>;
>> +       };
>> +
>> +}
>> diff --git a/Documentation/devicetree/bindings/ddr/ddr_timings.txt b/Documentation/devicetree/bindings/ddr/ddr_timings.txt
>> new file mode 100644
>> index 0000000..38fcdec
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ddr/ddr_timings.txt
>> @@ -0,0 +1,62 @@
>> +* AC timing parameters of DDR memories for a given speed-bin
>> +  At the moment properties for only LPDDR2 and DDR3 have been added
>> +
>> +Required properties:
>> +- min-freq : minimum DDR clock frequency for the speed-bin
>> +- max-freq : maximum DDR clock frequency for the speed-bin
>
> There should be a compatible field here too, especially if the binding
> ever has to be revised.

Ok. Bindings may have to be extended while adapting for other
controllers.

>
>> +
>> +Optional properties:
>> +
>> +The following properties represent AC timing parameters from the memory
>> +data-sheet of the device for a given speed-bin. All these properties are
>> +of type<u32>  and "-ps", "-ns", "-nCK" etc in the name indicates the
>> +unit of the corresponding parameter:
>> +  ps - pico seconds
>> +  ns - nano seconds
>> +  nCK - number of DDR clock cycles. Please note that in LPDDR2 spec and
>> +  data-sheets tCK is used inter-changeably for nCK. Both are equivalent
>> +  in this context.
>
> Seems noisy to include the units on every single property instead of
> just in the bindings.

Hmm.. How about having them only for the exceptions below, that is,
"nCK" and "ns" so that people don't make avoidable mistakes while
entering the data.

>
>> +
>> +- tRCD-ps
>> +- tWR-ps
>> +- tRAS-min-ps
>> +- tRRD-ps
>> +- tWTR-ps
>> +- tXP-ps
>> +- tRTP-ps
>> +- tDQSCK-max-ps
>> +- tFAW-ps
>> +- tZQCS-ps
>> +- tZQinit-ps
>> +- tRP-ps       /* DDR3 only */
>> +- tRC-ps       /* DDR3 only */
>> +- tXSDLL-nCK   /* DDR3 only */
>> +- tCKE-ps      /* DDR3 only */
>> +- tZQoper-ps   /* DDR3 only */
>> +- tRPab-ps     /* LPDDR2 only */
>> +- tZQCL-ps     /* LPDDR2 only */
>> +- tCKESR-ps    /* LPDDR2 only */
>> +- tRAS-max-ns  /* LPDDR2 only */
>
> Same above about type-specific properties.

Explained above.


Thanks for the review.

best regards,
Aneesh
