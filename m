From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Tue, 25 Oct 2011 12:31:51 +0530
Message-ID: <4EA65EDF.2070803@ti.com>
References: <20111021082309.GA337@S2100-06.ap.freescale.net>
	<20111024092411.GE8708@ponder.secretlab.ca>
	<20111024130429.GD1755@S2100-06.ap.freescale.net>
	<20111024130636.GB26033@opensource.wolfsonmicro.com>
	<20111024134025.GE1755@S2100-06.ap.freescale.net>
	<20111024135950.GV8708@ponder.secretlab.ca>
	<20111024145139.GH1755@S2100-06.ap.freescale.net>
	<20111024145631.GB8708@ponder.secretlab.ca>
	<20111024155132.GI1755@S2100-06.ap.freescale.net>
	<4EA652DA.5050901@ti.com>
	<20111025070837.GE2119@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111025070837.GE2119@S2100-06.ap.freescale.net>
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
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 25 October 2011 12:38 PM, Shawn Guo wrote:
> On Tue, Oct 25, 2011 at 11:40:34AM +0530, Rajendra Nayak wrote:
>> On Monday 24 October 2011 09:21 PM, Shawn Guo wrote:
>>> On Mon, Oct 24, 2011 at 04:56:31PM +0200, Grant Likely wrote:
> [...]
>>>> It is always better to attach the of_node at struct device
>>>> registration time instead of searching the tree in common code.  The
>>>> of_node should already be assigned by the time regulator_register() is
>>>> called.
>>>
>>> That's the problem we have.  There is no 'struct dev' to attach of_node
>>> for each regulator by the time regulator_register() is called, because
>>> the 'struct dev' for each regulator is created inside
>>> regulator_register() as wrapped by 'struct regulator_dev'.
>>
>> The root of your problem seems to be that your pmic driver isn't
>> registering regulator devices from DT, and if it did, you wouldn't
>> need to do a search in dev->parent->of_node and instead the driver
>> would have the right dev->of_node populated.
>>
> No, it's not the root of my problem.  Again, we are talking about
> 'Case 2', where multiple regulator devices are registered to
> regulator core with regulator driver being probed once, where each
> regulator node is taken as the child of 'regulators' node.  Having
> device_node of 'regulators' attached to dev->of_node does not help
> at all.  What we need is to have each child node attached to
> regulator_dev->dev.of_node.

It certainly helps if dev->of_node has the 'regulators' node attached.
The driver can very easily then do a for_each_child_of_node() to extract
and register individual regulators passing an additional of_node param.

>
