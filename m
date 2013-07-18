From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v9 1/8] drivers: phy: add generic PHY framework
Date: Thu, 18 Jul 2013 11:57:20 +0530
Message-ID: <51E78AC8.3020203@ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <1372247257-30186-2-git-send-email-kishon@ti.com>
 <20130717062944.GA24968@kroah.com> <51E664CB.8050906@ti.com>
 <20130717172510.GB17093@kroah.com> <51E78525.9000802@ti.com>
 <20130718062447.GA19997@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130718062447.GA19997@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mchehab@redhat.com, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, swarren@nvidia.com, grant.likely@linaro.org, cesarb@cesarb.net, george.cherian@ti.com, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, rob.herring@calxeda.com, linux@arm.linux.org.uk, sylvester.nawrocki@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com, rob@landley.net, benoit.cousson@linaro.org, akpm@linux-foundation.org, shawn.guo@linaro.org, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

On Thursday 18 July 2013 11:54 AM, Greg KH wrote:
> On Thu, Jul 18, 2013 at 11:33:17AM +0530, Kishon Vijay Abraham I wrote:
>>>> Wanted to group all the PHY drivers to be used by different subsystems
>>>> (SATA/USB/PCIE/HDMI/VIDEO) into a single entity. There were some comments in my
>>>> initial version [3] on using a bus_type instead of class but then it was
>>>> decided to go with class itself.
>>>>
>>>> [3] -> http://lkml.indiana.edu/hypermail/linux/kernel/1302.2/01389.html
>>>
>>> Ok, but what does the class usage get you?
>>
>> hmm.. actually I use class only to iterate through the list of devices in *phy*
>> class which could very well be implemented using list. Just that I wont have a
>> /sys/class/phy/ entry to find the list of phys added in the system. I dont
>> think I want to add any other stuff to expose to the user space at this point
>> of time.
>>>
>>>>> When modifying/adding new sysfs stuff, you need a Documentation/ABI/
>>>>> entry as well.
>>>>
>>>> I'm not actually adding any new sysfs entry other than what a *class_create*
>>>> must have created. Do I need to add one for that?
>>>
>>> If you are not creating anything in sysfs at all, why use the driver
>>> model?  (hint, I think you need to do something here to justify it...)
>>
>> Well.. it helps me to use pm_runtime to enable clocks utilizing the
>> parent-child relationship.
> 
> Ok, that's a good reason for this, nevermind then.  Care to send the
> latest patches you have in emails so I can review them?

Sure.

Thanks
Kishon
