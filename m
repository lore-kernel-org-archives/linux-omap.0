From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Date: Tue, 9 Feb 2016 16:16:16 -0600
Message-ID: <56BA6530.4030102@ti.com>
References: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
 <20160209220901.GC28102@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160209220901.GC28102@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On 02/09/2016 04:09 PM, Eduardo Valentin wrote:
> On Mon, Feb 08, 2016 at 03:15:05PM +0530, Keerthy wrote:
>> The thermal threholds for am57xx are different from that of dra7.
>> Correcting the thresholds for the same.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Depends on: https://lkml.org/lkml/2016/2/8/90
>>
>>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
>> ===================================================================
>> --- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.514959101 +0530
>> +++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.510959168 +0530
> 
> Sorry, did not bother to check, but is this the only user of am57xx?

we will have AM57xx-IDK as well coming down the line. we already have
arch/arm/boot/dts/am57xx-cl-som-am57x.dts
arch/arm/boot/dts/am57xx-sbc-am57x.dts - not really sure what grade of
silicon are used in cl-SOM and sbc boards.


-- 
Regards,
Nishanth Menon
