From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if display
	is enabled in bootloader
Date: Mon, 3 Oct 2011 11:46:16 +0200
Message-ID: <4E898468.2060508@ti.com>
References: <1315811306-11001-1-git-send-email-archit@ti.com>
	<alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
	<1317630070.2026.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317630070.2026.27.camel@deskari>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "R,
	Sricharan" <r.sricharan@ti.com>, "Shilimkar,
	Santosh" <santosh.shilimkar@ti.com>, "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On 10/3/2011 10:21 AM, Valkeinen, Tomi wrote:
> Hi Paul,
>
> On Sun, 2011-10-02 at 22:45 -0600, Paul Walmsley wrote:

[...]

>> +struct omap_dss_dispc_dev_attr {
>> +	u8	manager_count;
>> +	bool	has_framedonetv_irq;
>> +};
>> +
>> +#endif
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> index 09d9395..8e32cb3 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> @@ -945,6 +945,7 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod = {
>>   	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_dispc_slaves),
>>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>>   	.flags		= HWMOD_NO_IDLEST,
>> +	.dev_attr	=&omap2_3_dss_dispc_dev_attr
>>   };
>
> I didn't know you can add arbitrary data like that to hwmods. What kind
> of data is it meant for? Can the data be used by the driver, or is it
> meant just for arch stuff?

It was added in order to add HW related information for an IP.
So most of the time, this is use for IP version, since this information 
is not necessarily accessible from the IP itself. Some time it can be 
the number of entries in the mailbox IP that will change depending of 
the version too.

> I'm wondering this as we have a complex mechanism in the dss driver to
> find out about the differences of DSS hardware
> (drivers/video/omap2/dss/dss_features.[ch]). The dss_features system is
> currently part of the driver, but should be moved under arch/arm/*omap*
> at some point, and this hwmod dev_attr sounds like it could possibly be
> a right place to handle these.

Please note that I made that kind of comment to Archit when he started 
submitted this dss_feature series. That feature management mechanism 
could have been useful for any other IPs / driver at that time.

> I looked at how the dev_attrs are used, and all of them seemed to be
> very small, a few fields at max. The DSS features set is, on the other
> hand, quite big amount of data, and meant for the driver.

That's why, most of the time, only the version is in the dev_attr, and 
the various information that will depend of that version are stored in 
the driver.

But at that time, device tree was not there...
Now, the whole dev_attr stuff will be replaced because device tree is 
able to provide the driver any kind of custom information that can be 
retrieved directly from the driver without having to use a pdata in 
between. So I'm not sure it worth spending too much time on that feature 
stuff.

As an example here is the ongoing GPIO DT migration:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg56505.html

3.2 will have the basic DT support using hwmod as a backend, but the 
idea is that for 3.3, we start removing some information from hwmod to 
rely on device tree only.

Regards,
Benoit
