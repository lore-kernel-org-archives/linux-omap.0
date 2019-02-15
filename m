From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Thu, 14 Feb 2019 19:22:23 -0600
Message-ID: <3386fca7-73dd-db69-e179-bb90681cf28c@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <16001a6f-faed-ee14-5ade-79d5462f6d51@ti.com> <5C654C39.2030308@ti.com>
 <20190214155640.GD5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214155640.GD5720@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, dan@kulp.com, Matthijs van Duin <matthijsvanduin@gmail.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 2/14/19 9:56 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190214 11:09]:
>> Suman is mainly concerned about the following changes in v2
>> 1) pruss node does not contain reg property representing entire ICSS.
>> 2) pruss node does not contain interrupts.
>>
>> Both of these are required if drivers/uio/uio_pruss.c or in future if
>> VFIO is to be used.
>>
>> The beagleboard community is a primary user of this driver and we need to
>> find a solution so that PRUSS is usable either via remoteproc or via UIO.
>>
>> Ideal case should allow user to use either of the drivers by just doing
>> a unbind and bind.
>>
>> I don't have a better idea than having a encapsulating node that has
>> the appropriate reg and interrupt properties.
> 
> If there are existing use cases that need to be supported
> you should list them as non-standard usage in the binding
> and not recommended for future use. Rob may have some
> comments on how to deal with this.
> 
> Then you can have device driver that needs to pass them
> parse them from the PRUSS parent node. That does not mean
> there needs to be a top level device driver for PRUSS,
> the child control module can just parse the non-standard
> bindings for compability from the parent node.

The PRUSS SoC bus driver was handling all possible architectures (OMAP,
K2 and K3) which have different clocking and reset integration, and also
catering to the UIO vs remoteproc usecases, by taking care of clocks and
resets. I am ok to replace this layer with the ti-sysc layer on OMAP
SoCs since most of the functionality added to the driver is associated
with OCP, but we would still need a PRUSS driver.

Not all sub-modules are peripherals and managed by respective peripheral
drivers, and we still need a central entity managing the sub-system wide
resources. Layering wise - it is similar if we would have done a device
for the PRUSS local interconnect, but that driver wouldn't have much to
do with interconnect functionality. K2 and K3 families uses TI-SCI and
so you don't have a similar target-module concept that allows you to
query the PRUSS parent node for PRUSS specific ranges or properties.
In anycase, I don't think these drivers should depend on a parent
interconnect driver.

regards
Suman


> 
> And naturally in addition to handling the non-standard
> binding we need to have a proper standardized binding
> too :)
> 
> Regards,
> 
> Tony
> 
