From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: remove *.auto* from device names given
 in usb_bind_phy
Date: Tue, 30 Jul 2013 13:41:23 +0530
Message-ID: <51F7752B.8050804@ti.com>
References: <20130729150638.GD3063@radagast> <51F68A56.8060805@ti.com>
 <20130729175413.GC4964@radagast> <51F74BC8.7020903@ti.com>
 <20130730060134.GD9155@radagast> <51F7590B.4020705@ti.com>
 <20130730061830.GE9155@radagast> <51F75C40.4060406@ti.com>
 <20130730062844.GH9155@radagast> <51F7613C.5070803@ti.com>
 <20130730071611.GD16441@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130730071611.GD16441@radagast>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: linux@arm.linux.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, eballetbo@gmail.com, javier@dowhile0.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 30 July 2013 12:46 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 30, 2013 at 12:16:20PM +0530, Kishon Vijay Abraham I wrote:
>>>>>> the list of controller device (names) it can support (PHY framework does not
>>>>>> maintain a separate list for binding like how we had in USB PHY library). e.g.
>>>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92817.html. In such
>>>>>
>>>>> this has nothing to do with $subject though. We talk about generic PHY
>>>>> framework once all these PHY drivers are moved there :-)
>>>>>
>>>>>> cases how do we pass the device names. Also will the MUSB core device be
>>>>>> created before twl4030-usb PHY device?
>>>>>
>>>>> and why would that be a problem ? We're telling the framework that the
>>>>> musb device will use a phy with a name of 'twl4030'. If musb calls
>>>>> usb_get_phy_dev() and doesn't find a phy, it'll return -EPROBE_DEFER and
>>>>> try again later.
>>>>
>>>> I think we are talking about different problems here ;-) I'm trying to tell
>>>> using idr in MUSB core is needed for Generic PHY Framework. So in a way, the
>>>> Generic PHY Framework series depends on this patch series or else MUSB in OMAP3
>>>> platforms wont work after Generic PHY framework gets merged.
>>>
>>> then you just found a limitation in your framework, right ? :-) I mean,
>>> imagine if now we have to add an IDR to every single user of your
>>> framework because they could end up in systems with multiple instances
>>> of the same IP ?
>>
>> I raised a similar concern in the PHY framework discussion [1] :-) And since
>> it's used everywhere else regulators, clkdev, etc.. it's agreed to be used in
>> PHY as well. Btw if PLATFORM_DEVID_AUTO is used even regulator, clk_get should
>> fail IMO.
>>
>> [1] -> http://lkml.indiana.edu/hypermail/linux/kernel/1307.2/03573.html
> 
> look at Greg's and my reply to that email.

but finally Greg agreed to what Tomasz proposed no?

Thanks
Kishon
