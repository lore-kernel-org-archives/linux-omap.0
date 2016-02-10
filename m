From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
Date: Wed, 10 Feb 2016 09:07:37 +0530
Message-ID: <56BAB081.5040005@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160208195704.GW19432@atomide.com> <56B95EF7.9080107@ti.com>
 <20160209215326.GC27284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160209215326.GC27284@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 10 February 2016 03:23 AM, Eduardo Valentin wrote:
> On Tue, Feb 09, 2016 at 09:07:27AM +0530, Keerthy wrote:
>>
>>
>> On Tuesday 09 February 2016 01:27 AM, Tony Lindgren wrote:
>>> * Keerthy <j-keerthy@ti.com> [160208 01:19]:
>>>> OMAP5 has 3 thermal zones cpu, core and multimedia.
>>>> On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
>>>> and iva. Currently cpu, core and multimedia are being added via dt
>>>> and the other 2 are getting added via kernel. Add the missing thermal
>>>> domains in dt so as give the correct trip numbers, type and temperatures.
>
> But the driver would add these default domains only if booted /loaded with
> missing DT device entry, right?

Yes Eduardo, but with default trip values not the absolute which is 
added with this patch series.

>
