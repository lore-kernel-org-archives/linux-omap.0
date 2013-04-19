From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Fri, 19 Apr 2013 10:56:28 -0500
Message-ID: <5171692C.1080407@ti.com>
References: <1366316595.4085.113.camel@mars> <5170738F.8050305@ti.com> <1366325282.4232.6.camel@lovely> <51708097.6070102@ti.com> <51708131.2040208@ti.com> <1366362081.3928.18.camel@mars> <1366372957.3928.104.camel@mars> <51714E0D.7020304@ti.com> <1366383208.3928.144.camel@mars> <5171647B.9070108@ti.com> <20130419154804.GH10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab3DSP4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 11:56:33 -0400
In-Reply-To: <20130419154804.GH10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org


On 04/19/2013 10:48 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130419 08:41]:
>> On 04/19/2013 09:53 AM, Christoph Fritz wrote:
>>> -static int omap2_nand_gpmc_retime(
>>> -				struct omap_nand_platform_data *gpmc_nand_data,
>>> -				struct gpmc_timings *gpmc_t)
>>> -{
>>> -	struct gpmc_timings t;
>>> -	int err;
>>> -
>>> -	memset(&t, 0, sizeof(t));
>>> -	t.sync_clk = gpmc_t->sync_clk;
>>> -	t.cs_on = gpmc_t->cs_on;
>>> -	t.adv_on = gpmc_t->adv_on;
>>> -
>>> -	/* Read */
>>> -	t.adv_rd_off = gpmc_t->adv_rd_off;
>>> -	t.oe_on  = t.adv_on;
>>> -	t.access = gpmc_t->access;
>>> -	t.oe_off = gpmc_t->oe_off;
>>> -	t.cs_rd_off = gpmc_t->cs_rd_off;
>>> -	t.rd_cycle = gpmc_t->rd_cycle;
>>> -
>>> -	/* Write */
>>> -	t.adv_wr_off = gpmc_t->adv_wr_off;
>>> -	t.we_on  = t.oe_on;
>>> -	if (cpu_is_omap34xx()) {
>>> -		t.wr_data_mux_bus = gpmc_t->wr_data_mux_bus;
>>> -		t.wr_access = gpmc_t->wr_access;
>>> -	}
>>> -	t.we_off = gpmc_t->we_off;
>>> -	t.cs_wr_off = gpmc_t->cs_wr_off;
>>> -	t.wr_cycle = gpmc_t->wr_cycle;
>>> -
>>> -	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>>  static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>>>  {
>>>  	/* support only OMAP3 class */
>>> @@ -131,7 +93,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>>>  				gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
>>>  
>>>  	if (gpmc_t) {
>>> -		err = omap2_nand_gpmc_retime(gpmc_nand_data, gpmc_t);
>>> +		err = gpmc_cs_set_timings(gpmc_nand_data->cs, gpmc_t);
>>>  		if (err < 0) {
>>>  			dev_err(dev, "Unable to set gpmc timings: %d\n", err);
>>>  			return err;
>>>
>>
>> Thanks for sending this. I would agree with this approach. The retime
>> function seems very redundant looking at what it does.
>>
>> Grep'ing through the source, the only place I see a board file call
>> gpmc_nand_init() and pass timings is in
>> arch/arm/mach-omap2/board-flash.c. To keep the gpmc configuration
>> consistent, I would also suggest making the following change so that
>> oe_on and we_on are programmed as they would be by the current retime
>> function.
> 
> What about DVFS though? The L3 clock can get rescaled with DVFS,
> and after that the retime function needs to get called. We are
> not doing it in the mainline tree, but at least n8x0 - n900 vendor
> trees were doing it.

I wondered if you would mention that ;-)

If you look at the implementation of the omap2_nand_gpmc_retime(), it
does not actually perform any retiming base upon frequency whatsoever
(unlike smc91c96_gpmc_retime). So right now omap2_nand_gpmc_retime is a
basic wrapper around gpmc_cs_set_timings() really adding no value.
Hence, I agree with Christoph's patch to remove it.

Cheers
Jon
