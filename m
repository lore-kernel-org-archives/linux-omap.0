From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
Date: Wed, 28 Sep 2011 10:20:51 +0200
Message-ID: <4E82D8E3.8080405@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-3-git-send-email-b-cousson@ti.com>
	<4E8161C7.7020404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E8161C7.7020404@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

I missed one comment...

On 9/27/2011 7:40 AM, Nayak, Rajendra wrote:
> On Monday 26 September 2011 10:20 PM, Benoit Cousson wrote:

[...]

>> +Required properties:
>> +- compatible:
>> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
>
> Would it be more readable to have
> "ti,omap2-gpio" for OMAP2 controllers and
> "ti,omap3-gpio" for OMAP3 controllers?

The point here is to identify the IP version used in various OMAPs. 
Since OMAP3 and OMAP2 are using the same IP version, there is no point 
to differentiate the OMAP3 version.
What is doable is to put both "ti,omap3-gpio", "ti,omap2-gpio" to avoid 
modifying the driver for no reason and still being able to identify the 
OMAP3 version.
But I'm not sure we should do that if there is not real difference.

regards,
Benoit
