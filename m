From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Thu, 25 Jul 2013 10:41:15 +0530
Message-ID: <51F0B373.5050907@ti.com>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
 <5977067.8rykRgjgre@flatron> <201307242032.03597.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201307242032.03597.arnd@arndb.de>
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
Cc: linux-fbdev@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-doc@vger.kernel.org, tony@atomide.com, Tomasz Figa <t.figa@samsung.com>, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, george.cherian@ti.com, Stephen Warren <swarren@wwwdotorg.org>, b.zolnierkie@samsung.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 25 July 2013 12:02 AM, Arnd Bergmann wrote:
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

The OMAP3 platforms still needs to be supported for non-dt :-s

Thanks
Kishon
