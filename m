From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 21:58:34 +0530
Message-ID: <51EEAF32.4040905@ti.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com> <20130723161846.GD2486@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130723161846.GD2486@kroah.com>
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
Cc: linux-fbdev@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, Stephen Warren <swarren@wwwdotorg.org>, b.zolnierkie@samsung.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.park@samsung.com, broonie@kernel.org, olof@lixom.neta
List-Id: linux-omap@vger.kernel.org

Hi Greg,

On Tuesday 23 July 2013 09:48 PM, Greg KH wrote:
> On Tue, Jul 23, 2013 at 08:48:24PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Tuesday 23 July 2013 08:07 PM, Alan Stern wrote:
>>> On Tue, 23 Jul 2013, Tomasz Figa wrote:
>>>
>>>> On Tuesday 23 of July 2013 09:29:32 Tomasz Figa wrote:
>>>>> Hi Alan,
>>>
>>> Thanks for helping to clarify the issues here.
>>>
>>>>>> Okay.  Are PHYs _always_ platform devices?
>>>>>
>>>>> They can be i2c, spi or any other device types as well.
>>>
>>> In those other cases, presumably there is no platform data associated
>>> with the PHY since it isn't a platform device.  Then how does the
>>> kernel know which controller is attached to the PHY?  Is this spelled
>>> out in platform data associated with the PHY's i2c/spi/whatever parent?
.
.
<snip>
.
.
>>
>> 	static struct phy *phy_lookup(void *priv) {
>> 		.
>> 		.
>> 		if (phy->priv==priv) //instead of string comparison, we'll use pointer
>> 			return phy;
>> 	}
>>
>> PHY driver should be like
>> 	phy_create((dev, ops, pdata->info);
>>
>> The controller driver would do
>> 	phy_get(dev, NULL, pdata->info);
>>
>> Now the PHY framework will check for a match of *priv* pointer and return the PHY.
>>
>> I think this should be possible?
> 
> Ick, no.  Why can't you just pass the pointer to the phy itself?  If you
> had a "priv" pointer to search from, then you could have just passed the
> original phy pointer in the first place, right?
> 
> The issue is that a string "name" is not going to scale at all, as it
> requires hard-coded information that will change over time (as the
> existing clock interface is already showing.)
> 
> Please just pass the real "phy" pointer around, that's what it is there
> for.  Your "board binding" logic/code should be able to handle this, as
> it somehow was going to do the same thing with a "name".

The problem is the board file won't have the *phy* pointer. *phy* pointer is
created at a much later time when the phy driver is probed.

Thanks
Kishon
