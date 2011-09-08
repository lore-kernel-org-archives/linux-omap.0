From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in
 DT
Date: Thu, 8 Sep 2011 09:14:57 +0200
Message-ID: <4E686B71.2060107@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-7-git-send-email-b-cousson@ti.com>
	<CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
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

Hi Ohad,

On 9/7/2011 9:58 PM, Ohad Ben-Cohen wrote:
> On Wed, Aug 24, 2011 at 4:09 PM, Benoit Cousson<b-cousson@ti.com>  wrote:
>> Add a device-tree node for the spinlock.
>> Remove the static device build code if CONFIG_OF
>> is set.
>> Update the hwspinlock driver to use the of_match method.
>> Add the information in Documentation/devicetree.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Ohad Ben-Cohen<ohad@wizery.com>
>> ---
> ...
>> +               spinlock {
>> +                       compatible = "ti,omap-spinlock";
>> +                       hwmods = "spinlock";
>> +               };
>
> This seem to satisfy the current hwspinlock driver, but I'm wondering
> about an issue which was discussed awhile ago by Arnd and Mathieu:
>
> Hwspinlock devices provide system-wide hardware locks that are used by
> remote processors that have no other way to achieve synchronization.
>
> For that to work, each physical lock must have a system-wide unique id
> number that all processors are familiar with, otherwise they can't
> possibly assume they're using the same hardware lock.
>
> Usually SoC have a single hwspinlock device, which provides several
> hardware spinlocks, and in this case, the locks can be trivially
> numbered 0 to (num-of-locks - 1).
>
> In case boards have several hwspinlocks devices (each of which
> providing numerous hardware spinlocks) a different base id should be
> used for each hwspinlock device (they can't all use 0 as a starting
> id!).
>
> While this is certainly not common, it's just plain wrong for the
> hwspinlock driver to silently use 0 as a base id whenever it is probed
> with a device (and by that implicitly assume there will always be only
> one device).

Hehe, I'm not the one who wrote that driver :-)

This is not wrong for the current HW. The point is do we want to 
anticipate potential HW evolution that might never happen on that IP?

> So we need to couple an hwspinlock device with a base id (which is
> trivially zero when there's only a single hwspinlock device). This can
> be easily achieved today using platform data, which boards will use to
> set a different base id for each of the hwspinlock devices they have
> (i'll send a patch demonstrating this soon), but I'm wondering how to
> specify this hwspinlock-specific data with DT: is there an existing
> binding we can use for this ? or should we create something like a
> "baseid" one especially for the hwspinlock driver ?

This is no different than the multiple GPIO controllers we have today.
Since we cannot rely on the DT nodes order, I added an explicit "id" 
attribute to provide that information to the driver. And then the baseid 
is "id * #gpios".

>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id spinlock_match[] = {
>> +       {.compatible = "ti,omap-spinlock", },
>> +       {},
>> +}
>
> you're missing a semicolon there (yeah I actually tried to build this ;)

That was a test :-)
In fact it looks like this driver is not built with a default 
omap2plus_defconfig :-(
I'll fix that.

Thanks for the review,
Benoit
