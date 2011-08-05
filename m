From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match
	to work?
Date: Fri, 5 Aug 2011 14:31:16 +0200
Message-ID: <4E3BE294.2020404@ti.com>
References: <4E396361.3060307@ti.com>
	<CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
	<CAGsJ_4x7LWRGWXsWzMG1FxZPaFYiKSUpSac2PdwH=d6vqFWRfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGsJ_4x7LWRGWXsWzMG1FxZPaFYiKSUpSac2PdwH=d6vqFWRfw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 8/5/2011 12:02 PM, Barry Song wrote:
>> auxdata passes platform_data and overrides the device name when there
>> is no way easy way to make the driver work without it.  It handles the
>> the current implementation of clocks and regulators which aren't yet
>> populated from the device tree.  It will go away when clock&
>> regulator bindings are implemented.
> Yes. As OF_DEV_AUXDATA_ID still requires hardware information like
> 0x48000100 as below, it seems it is not
> consistent with the origin purpose of ARM DT.
> OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c.1", 1,&i2c_pdata)
> And the information 0x48000100 is something that doesn't want to be in
> kernel codes.it should be only in dts.

FWIW, I do not care about the physical address at all. This is just used 
by the of_dev_lookup function to get the proper instance for a device 
compatible type.
That's the only way for the OF_DEV_AUXDATA to work, but in theory you 
could do the same as soon as you provide the id. So OF_DEV_AUXDATA_ID 
could avoid it.

Since OF_DEV_AUXDATA_ID seems to be already dead before it even reaches 
the mainline, let's forget about that.

Regards,
Benoit
