From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/14] ARM: OMAP2+: Add function for configuring GPMC
 settings
Date: Thu, 28 Feb 2013 09:52:56 -0600
Message-ID: <512F7D58.90706@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-5-git-send-email-jon-hunter@ti.com>
 <518397C60809E147AF5323E0420B992E3EA8F007@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA8F007-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 02/28/2013 12:05 AM, Philip, Avinash wrote:
> On Tue, Feb 26, 2013 at 23:00:31, Hunter, Jon wrote:
>> The GPMC has various different configuration options such as bus-width,
>> synchronous or asychronous mode selection, burst mode options etc.
>> Currently, there is no common function for configuring these options and
>> various devices set these options by either programming the GPMC CONFIG1
>> register directly or by calling gpmc_cs_configure() to set some of the
>> options.
>>
>> Add a new function for configuring all of the GPMC options. Having a common
>> function for configuring this options will simplify code and ease the
>> migration to device-tree.
>>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/mach-omap2/gpmc.c |   65 ++++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/gpmc.h |    6 ++++
>>  2 files changed, 71 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index 465cac9..fb8dfd2 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -1137,6 +1137,71 @@ int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
>>  	return 0;
>>  }
>>  
>> +int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
>> +{
>> +	u32 config1;
>> +
>> +	if ((!p->device_width) || (p->device_width > GPMC_DEVWIDTH_16BIT)) {
>> +		pr_err("%s: invalid width %d!", __func__, p->device_width);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Address-data multiplexing not supported for NAND devices */
>> +	if (p->device_nand && p->mux_add_data) {
>> +		pr_err("%s: invalid configuration!\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Page/burst mode supports lengths of 4, 8 and 16 bytes */
>> +	if (p->burst_read || p->burst_write) {
>> +		switch (p->burst_len) {
>> +		case GPMC_BURST_4:
>> +		case GPMC_BURST_8:
>> +		case GPMC_BURST_16:
>> +			break;
>> +		default:
>> +			pr_err("%s: invalid page/burst-length (%d)\n",
>> +			       __func__, p->burst_len);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	if ((p->wait_on_read || p->wait_on_write) &&
>> +	    (p->wait_pin > gpmc_nr_waitpins)) {
>> +		pr_err("%s: invalid wait-pin (%d)\n", __func__, p->wait_pin);
>> +		return -EINVAL;
>> +	}
>> +
>> +	config1 = GPMC_CONFIG1_DEVICESIZE((p->device_width - 1));
> 
> Can you consider read_modify approach?

I was purposely trying to avoid that. The intent here is to program all
the settings and get away from any boot-loader dependencies. If we use a
read-modify approach then it will never be clear in the kernel what
should actually be programmed.

Cheers
Jon
