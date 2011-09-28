From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based
	on supply name
Date: Wed, 28 Sep 2011 10:09:30 +0200
Message-ID: <4E82D63A.7030207@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-9-git-send-email-rnayak@ti.com>
	<20110927122155.GE4289@opensource.wolfsonmicro.com>
	<4E81E281.505@ti.com>
	<20110927185913.GU4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110927185913.GU4289@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "patches@linaro.org" <patches@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/27/2011 8:59 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 08:19:37PM +0530, Rajendra Nayak wrote:
>> On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
>>> On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:
>
>>>> +	if (!dev)
>>>> +		return NULL;
>
>>> So how do we handle CPUs?  cpufreq is one of the most active users of
>>> regulators...
>
>> Hmm, never thought of it :(
>> Maybe I should associate a supply name with all
>> regulators and then lookup from the global registered
>> list.
>
> I'm not sure how this should work in a device tree world, I'd *hope*
> we'd get a device tree node for the CPU and could then just make this a
> regular consumer thing but then the cpufreq drivers would need to be
> updated to make use of it.  The only reason we allow null devices right
> now is the fact that cpufreq doesn't have a struct device it can use.

That's why we do have a MPU node in OMAP dts, in order to build an 
omap_device that will be mainly used for the DVFS on the MPU.

And even before DT migration, we used to build statically some 
omap_device to represent the various processors in the system (MPU, DSP, 
CortexM3...).

Regards,
Benoit
