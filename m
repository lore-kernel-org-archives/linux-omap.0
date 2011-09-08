From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in
 DT
Date: Thu, 8 Sep 2011 10:07:05 +0200
Message-ID: <4E6877A9.3090104@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-7-git-send-email-b-cousson@ti.com>
	<CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
	<4E686B71.2060107@ti.com>
	<CAK=WgbYgatyLWqmrZnUfSGxCkZsRiJ3sbQwmenxyiJ6JBw5vJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbYgatyLWqmrZnUfSGxCkZsRiJ3sbQwmenxyiJ6JBw5vJA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/8/2011 9:56 AM, Ohad Ben-Cohen wrote:
> Hi Benoit,
>
> On Thu, Sep 8, 2011 at 10:14 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hehe, I'm not the one who wrote that driver :-)
>>
>> This is not wrong for the current HW. The point is do we want to anticipate
>> potential HW evolution that might never happen on that IP?
>
> I originally really thought we can ignore those cases (hence the 0
> base id ;), and personally I still think the scenario is a bit
> fictional, and wouldn't even mind just having omap_hwspinlock_probe()
> return an error if it is unexpectedly probed with a second device.
>
> But if fixing this entirely only means doing a small change, then it's
> surely nicer.

That should not be a big deal to add that kind of support.

>> This is no different than the multiple GPIO controllers we have today.
>> Since we cannot rely on the DT nodes order, I added an explicit "id"
>> attribute to provide that information to the driver. And then the baseid is
>> "id * #gpios".
>
> That would work if #hwspinlock is a fixed number, but a "baseid"
> attribute would allow supporting devices with different #hwspinlocks
> per device. Since I am not aware of any real hardware that does this
> kind of blasphemy, I can't say if the latter is really necessary :) If
> you prefer the former, I'm entirely fine with it.

The (small) issue for my point of view is that the #hwspinlock is 
already encoded in the IP itself. So adding a baseid directly in DT will 
look like duplicating indirectly something that is already there in the HW.
That being said, since we cannot rely on the order, we will not be able 
to get the proper baseid until the driver probe every hwspinlock devices 
:-(
So baseid might be a easier choice.

Regards,
Benoit
