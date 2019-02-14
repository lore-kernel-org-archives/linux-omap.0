From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 10/14] remoteproc/pru: Add PRU remoteproc driver
Date: Wed, 13 Feb 2019 21:44:26 -0600
Message-ID: <448fc985-9822-54b1-c0aa-070d6dcaad1a@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-11-git-send-email-rogerq@ti.com>
 <acf08e5e-d65f-84cf-5d3f-a8e0977933f4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <acf08e5e-d65f-84cf-5d3f-a8e0977933f4@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

On 2/13/19 8:35 PM, Suman Anna wrote:
> Hi Roger,
> 
> On 2/4/19 8:22 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The Programmable Real-Time Unit Subsystem (PRUSS) consists of
>> dual 32-bit RISC cores (Programmable Real-Time Units, or PRUs)
>> for program execution. This patch adds a remoteproc platform
>> driver for managing the individual PRU RISC cores life cycle.
>>
>> This remoteproc driver does not have support for error recovery
>> and system suspend/resume features. Different compatibles are
>> used to allow providing scalability for instance-specific device
>> data if needed. The driver uses a default firmware-name retrieved
>> from device-tree, and the firmwares are expected to be present
>> in the standard Linux firmware search paths. They can also be
>> adjusted by userspace if required through the sysfs interface
>> provided by the remoteproc core.
>>
>> The PRU remoteproc driver uses a client-driven boot methodology
>> - it does _not_ support auto-boot so that the PRU load and boot
>> is dictated by the corresponding client drivers for achieving
>> various usecases. This allows flexibility for the client drivers
>> or applications to set a firmware name (if needed) based on their
>> desired functionality and boot the PRU. The sysfs bind and unbind
>> attributes have also been suppressed so that the PRU devices cannot
>> be unbound and thereby shutdown a PRU from underneath a PRU client
>> driver.
>>
>> A new entry 'single_step' is added to the remoteproc debugfs dir.
>> The 'single_step' utilizes the single-step execution of the PRU
>> cores. Writing a non-zero value performs a single step, and a
>> zero value restores the PRU to execute in the same mode as the
>> mode before the first single step. (note: if the PRU is halted
>> because of a halt instruction, then no change occurs).
>>
>> pru_rproc_get() and pru_rproc_put() functions allow client drivers
>> to acquire and release the remoteproc device associated with a PRU core.
>> The PRU cores are treated as resources with only one client owning
>> it at a time.
>>
>> PRU interrupt mapping can be provided via devicetree using
>> ti,pru-interrupt-map property or via the resource table in the
>> firmware blob. If both are provided, the config in DT takes precedence.
>> For interrupt map via resource table, pru-software-support-package [1]
>> has been historically using version 0 for this. However, the current
>> data structure is not scaleable and is not self sufficient.
>> 1) it hard codes number of channel to host mappings so is not
>> scaleable to newer SoCs than have more of these.
>> 2) it does not contain the event to channel mappings within
>> itself but relies on a pointer to point to another section
>> in data memory. This causes a weird complication that the
>> respective data section must be loaded before we can really
>> use the INTC map.
>>
>> With this patch we drop support for version 0 and support
>> version 1 which is a more robust and scalable data structure.
>> It should be able to support a sufficiently large number (255) of
>> sysevents, channels and host interrupts and is self contained
>> so it can be used without dependency on order of loading sections.
> 
> Hmm, looks like you squashed a whole bunch of patches into this. I would
> prefer some of the logical ones to be separated out just like before,
> makes it easier to review the interfaces.
> 
> Looks like you have also changed usage behavior on couple of things and
> dropped some of my original changes. I was not able to test this series
> either on AM335x or on AM57xx to comment more on the behavior (not even
> seeing the pruss devices populated, not sure what pieces are missing still).

Able to get the PRUSS devices show up on AM335x atleast after enabling
the Reset Controller related configs, but no such luck on AM57xx.

regards
Suman

> 
>>
>> [1]  git://git.ti.com/pru-software-support-package/pru-software-support-package.git
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
