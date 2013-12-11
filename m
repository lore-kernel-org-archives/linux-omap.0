From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 04/10] usb: dwc3: use quirks to know if a particualr
 platform doesn't have PHY
Date: Wed, 11 Dec 2013 14:37:16 +0530
Message-ID: <52A82B44.10408@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1385373690-12170-5-git-send-email-kishon@ti.com>
 <20131204144027.GB21055@xps8300> <52A01E86.50406@ti.com>
 <20131205075828.GA32583@xps8300> <52A56DA1.1010808@ti.com>
 <20131209092604.GC5231@xps8300> <20131211085320.GD28456@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131211085320.GD28456@xps8300>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, balbi@ti.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, rob@landley.net, pawel.moll@arm.com, linux-doc@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@linaro.org, bcousson@baylibre.com, galak@codeaurora.org, swarren@wwwdotorg.org, s.nawrocki@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 11 December 2013 02:23 PM, Heikki Krogerus wrote:
> Hi,
> 
> On Mon, Dec 09, 2013 at 11:26:04AM +0200, Heikki Krogerus wrote:
>>>>>> Can you guys explain why is something like this needed? Like with
>>>>>> clocks and gpios, the device drivers shouldn't need to care any more
>>>>>> if the platform has the phys or not. -ENODEV tells you your platform
>>>>>
>>>>> Shouldn't we report if a particular platform needs a PHY and not able to get
>>>>> it. How will a user know if a particular controller is not working because it's
>>>>> not able to get and initialize the PHYs? Don't you think in such cases it's
>>>>> better to fail (and return from probe) because the controller will not work
>>>>> anyway without the PHY?
>>>>
>>>> My point is that you do not need to separately tell this to the driver
>>>> like you do with the quirks (if you did, then you would need to fix
>>>> your framework and not hack the drivers).
>>>>
>>>> Like I said, ENODEV tells you that there is no phy on this platform
>>>> for you, allowing you to safely continue. If your phy driver is not
>>>> loaded, the framework already returns EPROBE_DEFER, right. Any other
>>>
>>> right. but that doesn't consider broken dt data. With quirks we'll
>>> able to tell if a controller in a particular platform has PHY or not
>>> without depending on the dt data.
>>
>> Broken dt data? What kind of scenario are you thinking here? Do you
>> mean case where the dt does not describe the phy on a platform that
>> depends on it? Shouldn't that problem be fixed in the dt and not
>> hacked in the drivers? Or are you thinking about something else?
>>
>> Is there a case where something like that is actually happening?
> 
> I'm guessing I'm not getting an answer to this one.
> 
> Look, this patch will not work with ACPI enumerated devices. We will
> have a platform providing a single ACPI id, but there is a whole bunch
> of boards based on it and we have no way of telling which of them
> need/have phys to deal with and which ones don't.

Alright.. I'll drop this patch then.

Thanks
Kishon
