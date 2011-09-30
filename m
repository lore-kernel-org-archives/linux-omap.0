From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 30 Sep 2011 09:58:04 +0200
Message-ID: <4E85768C.6050601@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E854532.6080605@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "patches@linaro.org" <patches@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/30/2011 6:27 AM, Nayak, Rajendra wrote:

[...]

>> They need both.  We need to reference the device that provides the
>> supply and use a name to say which of the potentially multiple supplies
>> on the consumer device is which.
>
> Mark, I still seem to be a little confused with this one as to why
> we would need a phandle *and* a supply-name to reference a parent
> regulator/supply.
> The phandle would point to a regulator dt node and that node internally
> would have just one name associated with it.

I think as well that we should avoid considering a regulator with 
several outputs. I saw the same pattern used for the clock binding in DT 
as well.

A clock node like a regulator node should output only one signal.
These nodes should provide atomic functionality. And if extra 
functionality are needed we might consider adding some intermediate nodes.
Except for a regulator that will output several lines at the same 
voltage to spread the current load, assuming it does exist, I'm not sure 
to understand the need.

Mark,
What usage do you have in mind for such supply node with several outputs?

Regards,
Benoit
