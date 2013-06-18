From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v7 5/9] ARM: OMAP: USB: Add phy binding information
Date: Tue, 18 Jun 2013 16:43:44 +0530
Message-ID: <51C040E8.2050904@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com> <1371113039-5784-6-git-send-email-kishon@ti.com> <20130618094438.GT5461@arwen.pp.htv.fi> <51C030B4.5070707@ti.com> <20130618102725.GB7843@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130618102725.GB7843@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: grant.likely@linaro.org, tony@atomide.com, arnd@arndb.de, swarren@nvidia.com, sylvester.nawrocki@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, linux@arm.linux.org.uk, benoit.cousson@linaro.org, mchehab@redhat.com, cesarb@cesarb.net, davem@davemloft.net, rnayak@ti.com, shawn.guo@linaro.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 18 June 2013 03:57 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jun 18, 2013 at 03:34:36PM +0530, Kishon Vijay Abraham I wrote:
>> On Tuesday 18 June 2013 03:14 PM, Felipe Balbi wrote:
>>> On Thu, Jun 13, 2013 at 02:13:55PM +0530, Kishon Vijay Abraham I wrote:
>>>> In order for controllers to get PHY in case of non dt boot, the phy
>>>> binding information (phy device name) should be added in the platform
>>>> data of the controller.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> I would rather not pass strings around, any other way to handle this ?
>>> Why do you need to pass this string ?
>>
>> Our old way of binding the controller and the phy using device name
>> started creating problems after the devices are created using
>> PLATFORM_DEVID_AUTO. Infact non-dt boot is broken in mainline for
>> OMAP3 platforms for which I have posted a RFC series
>> http://www.serverphorums.com/read.php?12,708632 which also uses
>> strings.
>> I'm not sure of any other way to deal with this.
>
> have you checked how other frameworks handle it ? Regulator has some
> sort of binding in board-files, but I guess it passes the regulator
> name?

 From whatever I could make of, regulator has 3 ways to get the 
regulator one of which is using the binding in board-files (but it also 
uses device name which could create the same problem that we are facing).

1.) from dt data
2.) from _supply_ name
3.) from binding in board file

(referred regulator_dev_lookup() in regulator/core.c)

Thanks
Kishon
