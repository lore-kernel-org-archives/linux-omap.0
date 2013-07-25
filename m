From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Thu, 25 Jul 2013 11:29:46 +0200
Message-ID: <51F0F00A.1040907@samsung.com>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
 <5977067.8rykRgjgre@flatron> <201307242032.03597.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <201307242032.03597.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-doc@vger.kernel.org, tony@atomide.com, Tomasz Figa <t.figa@samsung.com>, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Kishon Vijay Abraham I <kishon@ti.com>, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, george.cherian@ti.com, Stephen Warren <swarren@wwwdotorg.org>, b.zolnierkie@samsung.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@
List-Id: linux-omap@vger.kernel.org

On 07/24/2013 08:32 PM, Arnd Bergmann wrote:
> On Tuesday 23 July 2013, Tomasz Figa wrote:
>> On Tuesday 23 of July 2013 17:14:20 Alan Stern wrote:
>>> On Tue, 23 Jul 2013, Tomasz Figa wrote:
>>>> Where would you want to have those phy_address arrays stored? There
>>>> are no board files when booting with DT. Not even saying that you
>>>> don't need to use any hacky schemes like this when you have DT that
>>>> nicely specifies relations between devices.
>>>
>>> If everybody agrees DT has a nice scheme for specifying relations
>>> between devices, why not use that same scheme in the PHY core?
>>
>> It is already used, for cases when consumer device has a DT node attached. 
>> In non-DT case this kind lookup translates loosely to something that is 
>> being done in regulator framework - you can't bind devices by pointers, 
>> because you don't have those pointers, so you need to use device names.
>>
> 
> Sorry for jumping in to the middle of the discussion, but why does a *new*
> framework even bother defining an interface for board files?
> 
> Can't we just drop any interfaces for platform data passing in the phy
> framework and put the burden of adding those to anyone who actually needs
> them? All the platforms we are concerned with here (exynos and omap,
> plus new platforms) can be booted using DT anyway.

Indeed, I was also a bit surprised we still need non-dt support, since
migration to this generic PHY framework in case of exynos was solely
part of migration of the whole platform to DT.

Two of the drivers that are being converted are also used on s5pv210,
but there is currently no boards in mainline that would use devices
covered by those drivers and s5pv210 will very likely get DT support
in v3.13 anyway.

But it seems omap still needs non-dt support in the PHY framework.

---
Thanks,
Sylwester
