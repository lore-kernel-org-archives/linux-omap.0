From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 13 Aug 2013 17:35:20 +0530
Message-ID: <520A2100.6000709@ti.com>
References: <20130720220006.GA7977@kroah.com>
 <20130731061538.GC13289@radagast> <520A0E1C.5000306@ti.com>
 <2034985.S0danJZqk4@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2034985.S0danJZqk4@amdc1227>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.park@samsung.com, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 August 2013 05:07 PM, Tomasz Figa wrote:
> On Tuesday 13 of August 2013 16:14:44 Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wednesday 31 July 2013 11:45 AM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Wed, Jul 31, 2013 at 11:14:32AM +0530, Kishon Vijay Abraham I wrote:
>>>>>>>>> IMHO we need a lookup method for PHYs, just like for clocks,
>>>>>>>>> regulators, PWMs or even i2c busses because there are complex
>>>>>>>>> cases
>>>>>>>>> when passing just a name using platform data will not work. I
>>>>>>>>> would
>>>>>>>>> second what Stephen said [1] and define a structure doing things
>>>>>>>>> in a
>>>>>>>>> DT-like way.
>>>>>>>>>
>>>>>>>>> Example;
>>>>>>>>>
>>>>>>>>> [platform code]
>>>>>>>>>
>>>>>>>>> static const struct phy_lookup my_phy_lookup[] = {
>>>>>>>>>
>>>>>>>>> 	PHY_LOOKUP("s3c-hsotg.0", "otg", "samsung-usbphy.1", "phy.2"),
>>>>>>>>
>>>>>>>> The only problem here is that if *PLATFORM_DEVID_AUTO* is used
>>>>>>>> while
>>>>>>>> creating the device, the ids in the device name would change and
>>>>>>>> PHY_LOOKUP wont be useful.
>>>>>>>
>>>>>>> I don't think this is a problem. All the existing lookup methods
>>>>>>> already
>>>>>>> use ID to identify devices (see regulators, clkdev, PWMs, i2c,
>>>>>>> ...). You
>>>>>>> can simply add a requirement that the ID must be assigned manually,
>>>>>>> without using PLATFORM_DEVID_AUTO to use PHY lookup.
>>>>>>
>>>>>> And I'm saying that this idea, of using a specific name and id, is
>>>>>> frought with fragility and will break in the future in various ways
>>>>>> when
>>>>>> devices get added to systems, making these strings constantly have
>>>>>> to be
>>>>>> kept up to date with different board configurations.
>>>>>>
>>>>>> People, NEVER, hardcode something like an id.  The fact that this
>>>>>> happens today with the clock code, doesn't make it right, it makes
>>>>>> the
>>>>>> clock code wrong.  Others have already said that this is wrong there
>>>>>> as
>>>>>> well, as systems change and dynamic ids get used more and more.
>>>>>>
>>>>>> Let's not repeat the same mistakes of the past just because we
>>>>>> refuse to
>>>>>> learn from them...
>>>>>>
>>>>>> So again, the "find a phy by a string" functions should be removed,
>>>>>> the
>>>>>> device id should be automatically created by the phy core just to
>>>>>> make
>>>>>> things unique in sysfs, and no driver code should _ever_ be reliant
>>>>>> on
>>>>>> the number that is being created, and the pointer to the phy
>>>>>> structure
>>>>>> should be used everywhere instead.
>>>>>>
>>>>>> With those types of changes, I will consider merging this subsystem,
>>>>>> but
>>>>>> without them, sorry, I will not.
>>>>>
>>>>> I'll agree with Greg here, the very fact that we see people trying to
>>>>> add a requirement of *NOT* using PLATFORM_DEVID_AUTO already points
>>>>> to a
>>>>> big problem in the framework.
>>>>>
>>>>> The fact is that if we don't allow PLATFORM_DEVID_AUTO we will end up
>>>>> adding similar infrastructure to the driver themselves to make sure
>>>>> we
>>>>> don't end up with duplicate names in sysfs in case we have multiple
>>>>> instances of the same IP in the SoC (or several of the same PCIe
>>>>> card).
>>>>> I really don't want to go back to that.
>>>>
>>>> If we are using PLATFORM_DEVID_AUTO, then I dont see any way we can
>>>> give the correct binding information to the PHY framework. I think we
>>>> can drop having this non-dt support in PHY framework? I see only one
>>>> platform (OMAP3) going to be needing this non-dt support and we can
>>>> use the USB PHY library for it.> 
>>> you shouldn't drop support for non-DT platform, in any case we lived
>>> without DT (and still do) for years. Gotta find a better way ;-)
>>
>> hmm..
>>
>> how about passing the device names of PHY in platform data of the
>> controller? It should be deterministic as the PHY framework assigns its
>> own id and we *don't* want to add any requirement that the ID must be
>> assigned manually without using PLATFORM_DEVID_AUTO. We can get rid of
>> *phy_init_data* in the v10 patch series.
> 
> What about slightly altering the concept of v9 to pass a pointer to struct 
> device instead of device name inside phy_init_data?

The problem is device might be created very late. (For example in omap4, usb2
phy device gets created when ocp2scp bus is probed). And we have to pass the
init data in board file.

Thanks
Kishon
