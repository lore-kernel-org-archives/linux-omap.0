From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Thu, 20 Oct 2011 17:39:32 +0530
Message-ID: <4EA00F7C.1080005@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111018132032.GD30703@S2100-06.ap.freescale.net>
	<4E9EB61C.1040207@ti.com>
	<20111019144215.GA32007@S2100-06.ap.freescale.net>
	<4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111020061408.GE32007@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 20 October 2011 11:44 AM, Shawn Guo wrote:
> On Thu, Oct 20, 2011 at 10:48:58AM +0530, Rajendra Nayak wrote:
>>> Let's look at mc13892-regulator driver.  There are 23 regulators defined
>>> in array mc13892_regulators.  Needless to say, there is a dev behind
>>> mc13892-regulator driver.  And when getting probed, this driver will
>>> call regulator_register() to register those 23 regulators individually.
>>> That said, for non-dt world, we have 1 + 23 'dev' with that 1 as the
>>> parent of all other 23 'dev' (wrapped by regulator_dev).  But with the
>>> current DT implementation, we will have at least 1 + 23 * 2 'dev'.
>>> These extra 23 'dev' is totally new with DT.
>>>
>>
>> but thats only because the mc13892-regulator driver is implemeted in
>> such a way that all the regulators on the platform are bundled in as
>> *one* device.
>
> I did not look into too many regulator drivers, but I expect this is
> way that most regulator drivers are implemented in.  Having
> mc13892-regulator being probed 23 times to register these 23 regulators
> just makes less sense to me.
>
>> It would again depend on how you would pass these from
>> the DT, if you indeed stick to the same way of bundling all regulators
>> as one device from DT, the mc13892-regulator probe would just get called
>> once and there would be one device associated, no?
>>
> Yes, I indeed would stick to the same way of bundling the registration
> of all regulators with mc13892-regulator being probed once.  The problem
> I have with the current regulator core DT implementation is that it
> assumes the device_node of rdev->dev (dev wrapped in regulator_dev) is
> being attached to rdev->dev.parent rather than itself.  Back to
> mc13892-regulator example, that said, it requires the dev of
> mc13892-regulator have the device_node of individual regulator attached
> to.  IOW, the current implementation forces mc13892-regulator to be
> probed 23 times to register those 23 regulators.  This is wrong to me.

I think I now understand to some extent the problem that you seem to be
reporting. It is mainly with drivers which bundle all regulators and
pass them as one device and would want to do so with DT too.

however I am still not clear on how what you seem to suggest would
solve this problem. Note that not all drivers do it this way, and
there are drivers where each regulator is considered as one device
and I suspect they would remain that way with DT too. And hence we
need to support both.

Do you have any RFC patch/code which could explain better what you are
suggesting we do here?
>
