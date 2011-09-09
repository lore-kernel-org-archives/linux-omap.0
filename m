From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 03/10] documentation/dt: Add l3-noc bindings
Date: Fri, 9 Sep 2011 02:18:47 +0200
Message-ID: <4E695B67.1010607@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-4-git-send-email-b-cousson@ti.com>
	<20110908180604.GC2967@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110908180604.GC2967@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/8/2011 8:06 PM, Grant Likely wrote:
> On Wed, Aug 24, 2011 at 03:09:09PM +0200, Benoit Cousson wrote:
>> Add documentation for the l3-noc bindings.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Randy Dunlap<rdunlap@xenotime.net>
>> ---
>>   .../devicetree/bindings/arm/omap/l3-noc.txt        |   18 ++++++++++++++++++
>>   1 files changed, 18 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
>> new file mode 100644
>> index 0000000..dbfa878
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
>> @@ -0,0 +1,18 @@
>> +* TI - L3 Network On Chip (NoC)
>> +
>> +This version is an implementation of the generic NoC IP
>> +provided by Arteris.
>
> Hahaha.  Here's the documentation.  Okay.
>
>> +
>> +Required properties:
>> +- compatible : Should be "ti,l3-noc", "arteris,noc"
>
> Should probably be "ti,omap4-l3-noc", and it isn't necessary to have a
> value for the IP core vendor... or at least if an arteris value is
> provided, then it should have some form of ip-core version
> information.

OK, in that case, the noc version is clearly not obvious to get, so I'll 
get rid of that compatible value.

>
>> +- hwmods: "l3_main_1", ... One hwmod for each noc domain.
>
> Is there some documentation on how the "hwmods" property is to be
> used?

Yes, it is part of the generic OMAP bindings documentation:
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-August/007621.html

> I expect that this should be "ti,hwmods" because this is a TI
> specific property.

OK.

Benoit
