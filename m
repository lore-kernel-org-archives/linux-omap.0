From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 11:04:53 +0530
Message-ID: <51EE15FD.2010205@ti.com>
References: <Pine.LNX.4.44L0.1307211453450.19133-100000@netrider.rowland.org>
 <51ECDE5E.3050104@ti.com> <20130722150458.GA18181@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130722150458.GA18181@kroah.com>
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
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-media@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, Sascha Hauer <s.hauer@pengutronix.de>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.park@samsung.com, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 22 July 2013 08:34 PM, Greg KH wrote:
> On Mon, Jul 22, 2013 at 12:55:18PM +0530, Kishon Vijay Abraham I wrote:
>>> 	The issue (or one of the issues) in this discussion is that 
>>> 	Greg does not like the idea of using names or IDs to associate
>>> 	PHYs with controllers, because they are too prone to
>>> 	duplications or other errors.  Pointers are more reliable.
>>>
>>> 	But pointers to what?  Since the only data known to be 
>>> 	available to both the PHY driver and controller driver is the
>>> 	platform data, the obvious answer is a pointer to platform data
>>> 	(either for the PHY or for the controller, or maybe both).
>>
>> hmm.. it's not going to be simple though as the platform device for the PHY and
>> controller can be created in entirely different places. e.g., in some cases the
>> PHY device is a child of some mfd core device (the device will be created in
>> drivers/mfd) and the controller driver (usually) is created in board file. I
>> guess then we have to come up with something to share a pointer in two
>> different files.
> 
> What's wrong with using the platform_data structure that is unique to
> all boards (see include/platform_data/ for examples)?  Isn't that what
> this structure is there for?

Alright. I got some ideas from Alan Stern. I'll use it with platform_data and
repost the series.

Thanks
Kishon
