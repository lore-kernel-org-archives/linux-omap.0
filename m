From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
Date: Tue, 15 Dec 2015 16:44:41 +0530
Message-ID: <566FF621.2040307@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <725110094.6UkMkcy8u7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <725110094.6UkMkcy8u7@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Tuesday 15 December 2015 04:26 PM, Arnd Bergmann wrote:
> On Tuesday 15 December 2015 14:45:59 Kishon Vijay Abraham I wrote:
>> This series is basically to deprecate using phy-omap-control and use
>> syscon APIs to program the control module registers.
>>
>> Changes from v2:
>> No changes.
>>
>> Changes from v1:
>> *) cleanup ti_pipe3_probe in multiple steps
>> *) other minor cleanups
>>
>> Changes from [1] in PHY patches include
>> *) cleanup ti_pipe3_probe
>> *) have mask, power_on and power_off values in usb_phy_data for
>>    omap-usb2 phy
>>
>> The patches have been pushed to
>>         git://git.ti.com/linux-phy/linux-phy.git syscon
>>
>> [1] -> https://lkml.org/lkml/2015/6/23/189
>>
>> All the testing was done both before applying the dt patches and after
>> applying the dt patches (dt patches will be posted shortly).
>>
> 
> Can you explain here what the conversion is good for? Why do you
> prefer the syscon mapping over a high-level driver in this case?

phy-omap-control driver was added when there was no proper
infrastructure for doing control module initializations. The
phy-omap-control driver is not an 'actual' PHY driver and it
was just a hack to do PHY related control module initializations.
phy-omap-control is also getting unmanageable with the number of
platforms each having number of modules (like USB, SATA, PCIe),
using the same driver for control module initializations.

Now with SYSCON framework being added to the kernel, phy-omap-control
shouldn't be needed and it also provides a uniform API across all the
modules to program the control module.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
