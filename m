From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH v3 01/11] usb: phy: Add APIs for runtime power management
Date: Thu, 4 Apr 2013 14:26:51 +0530
Message-ID: <CAFp+6iF9VJ5EneyVA9c6ggEa_RiUw0ZRBTRgh_gy--5ubP=8=Q@mail.gmail.com>
References: <20130403141831.GJ14680@arwen.pp.htv.fi>
	<Pine.LNX.4.44L0.1304031410320.2027-100000@iolanthe.rowland.org>
	<20130404071832.GD30287@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130404071832.GD30287@arwen.pp.htv.fi>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Alan Stern <stern@rowland.harvard.edu>, Kishon Vijay Abraham I <kishon@ti.com>, Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi,


On Thu, Apr 4, 2013 at 12:48 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Apr 03, 2013 at 02:14:02PM -0400, Alan Stern wrote:
>> > > Lets suppose DWC3 enables runtime_pm on USB 2 type phy,
>> > > it will try to go into suspend state and thereby call runtime_suspend(), if any.
>> > > And PHY will come to active state only when its consumer wakes it up,
>> > > and this consumer is operational
>> > > only when its related PHY is in fully functional state.
>> > > So do we have a situation in which this PHY goes into low power state
>> > > in its runtime_suspend(),
>> > > resulting in non-detection of devices on further attach (since PHY is
>> > > in low power state) ?
>> > >
>> > > Will the controller (like EHCI/OHCI) be functional now ?
>> >
>> > ehci/ohci need to cope with that by calling usb_phy_autopm_get_sync(),
>> > right ? (so does DWC3 :-)
>>
>> Maybe you guys have already got this all figured out -- if so, feel
>> free to ignore this email.
>>
>> Some subsystems handle this issue by calling pm_runtime_get_sync()
>> before probing a driver and pm_runtime_put_sync() after unbinding the
>> driver.  If the driver is runtime-PM-enabled, it then does its own
>> put_sync near the end of its probe routine and get_sync in its release
>> routine.
>
> sounds a bit 'fishy' to me... So a separate entity would call
> pm_runtime_get_sync(), even when we don't have registered dev_pm_ops,
> then drivers need to check if runtime_pm is enabled and call
> pm_runtime_put*() conditionally before returning from probe(). One
> remove, we might have another issue: device is already runtime_suspended
> (due to e.g. autosuspend) when module is removed, a call to
> pm_runtime_put_sync() will be unbalanced. No ?

May be i am misinterpreting !!
If PHYs are runtime-PM enabled (PHY probe calls *runtime_enable*),
then the consumers
need to call pm_runtime_get_sync whever they want to access PHY.
Besides PHYs also need to *put_sync* just before their probe is
finishing, so that it's
availbale for autosuspend.

I, however didn't understand the need of PHY to *get_sync* itself in
release routine.



-- 
Thanks & Regards
Vivek
