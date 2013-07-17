From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v9 1/8] drivers: phy: add generic PHY framework
Date: Wed, 17 Jul 2013 15:02:59 +0530
Message-ID: <51E664CB.8050906@ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <1372247257-30186-2-git-send-email-kishon@ti.com>
 <20130717062944.GA24968@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130717062944.GA24968@kroah.com>
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

Hi,

On Wednesday 17 July 2013 11:59 AM, Greg KH wrote:
> On Wed, Jun 26, 2013 at 05:17:29PM +0530, Kishon Vijay Abraham I wrote:
>> +menuconfig GENERIC_PHY
>> +	tristate "PHY Subsystem"
>> +	help
>> +	  Generic PHY support.
>> +
>> +	  This framework is designed to provide a generic interface for PHY
>> +	  devices present in the kernel. This layer will have the generic
>> +	  API by which phy drivers can create PHY using the phy framework and
>> +	  phy users can obtain reference to the PHY.
> 
> Shouldn't this be something that other drivers select?  How will anyone
> know if they need this or not?

All the PHY drivers should go here. So only if *GENERIC_PHY* is enabled those
PHY drivers can be selected like in [1].
The PHY consumer driver should ideally use *depends on* in their Kconfig.

[1] ->
http://archive.arm.linux.org.uk/lurker/message/20130628.134308.4a8f7668.ca.html
> 
>> --- /dev/null
>> +++ b/drivers/phy/phy-core.c
>> @@ -0,0 +1,544 @@
>> +/*
>> + * phy-core.c  --  Generic Phy framework.
>> + *
>> + * Copyright (C) 2013 Texas Instruments
>> + *
>> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
> 
> You really mean "any later version" (I have to ask)?

That was copied from somewhere :-s
> 
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> 
> Are these two paragraphs needed?  This isn't a "program", and they got a
> copy of the GPL already with the kernel.

hmm.. I can remove that.
> 
>> +static struct class *phy_class;
> 
> Why do you need a class?

Wanted to group all the PHY drivers to be used by different subsystems
(SATA/USB/PCIE/HDMI/VIDEO) into a single entity. There were some comments in my
initial version [3] on using a bus_type instead of class but then it was
decided to go with class itself.

[3] -> http://lkml.indiana.edu/hypermail/linux/kernel/1302.2/01389.html
> 
> When modifying/adding new sysfs stuff, you need a Documentation/ABI/
> entry as well.

I'm not actually adding any new sysfs entry other than what a *class_create*
must have created. Do I need to add one for that?

Thanks
Kishon
