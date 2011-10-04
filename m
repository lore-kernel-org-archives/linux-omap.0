From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Tue, 04 Oct 2011 17:32:47 +0530
Message-ID: <4E8AF5E7.8050402@ti.com>
References: <4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
	<20110930102849.GA4195@opensource.wolfsonmicro.com>
	<20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com>
	<20110930121844.GI5366@opensource.wolfsonmicro.com>
	<4E8A9988.3080907@ti.com>
	<20111004101846.GD3250@opensource.wolfsonmicro.com>
	<4E8AF090.4070304@ti.com>
	<20111004115153.GL3250@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111004115153.GL3250@opensource.wolfsonmicro.com>
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
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 04 October 2011 05:21 PM, Mark Brown wrote:
> On Tue, Oct 04, 2011 at 05:10:00PM +0530, Rajendra Nayak wrote:
>> On Tuesday 04 October 2011 03:48 PM, Mark Brown wrote:
>
>>> This seems fairly straightforward though it will require some changes
>>> within Linux, all we have to do is have the regulators name their
>>> supplies.
>
>> through dt? thats what the original bindings was doing.
>
> I wouldn't expect it done through DT (except for things like the fixed
> voltage regulator) - the driver should just know.

something like a
int regulator_set_supply(struct regulator_dev *rdev, char *supply_name);
to be called from drivers makes sense?
