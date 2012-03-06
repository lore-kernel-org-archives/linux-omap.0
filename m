From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 2/6] ARM: OMAP3 PM: Move IO Daisychain function to omap3
 prm file
Date: Tue, 06 Mar 2012 11:30:46 +0530
Message-ID: <4F55A80E.3090606@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-3-git-send-email-t-kristo@ti.com> <20120306054443.GA5670@kobold>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:51402 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751672Ab2CFGAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 01:00:55 -0500
Received: by mail-gx0-f176.google.com with SMTP id s6so2580603ggc.35
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 22:00:52 -0800 (PST)
In-Reply-To: <20120306054443.GA5670@kobold>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Vishwanath BS <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

On Tuesday 06 March 2012 11:14 AM, Nishanth Menon wrote:
> On 17:17-20120302, Tero Kristo wrote:
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> Since IO Daisychain modifies only PRM registers, it makes sense to move
>> it to PRM File. Also changed the timeout value for IO chain enable to
>> 100us and added a wait for status disable at the end.
>>
> [...]
>> +/*
>> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
>> + * the I/O ring after asserting WUCLKIN high
>> + */
>> +#define MAX_IOPAD_LATCH_TIME 100
>> +
>> +/* OMAP3 Daisychain enable sequence */
>> +void omap3_trigger_io_chain(void)
>> +{
>> +	int i = 0;
>> +
>> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>> +				   PM_WKEN);
>> +	/* Do a readback to assure write has been done */
>> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>> +
>> +	omap_test_timeout(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST)&
>> +			    OMAP3430_ST_IO_CHAIN_MASK) == 1),
> umm
> arch/arm/mach-omap2/prm-regbits-34xx.h:#define OMAP3430_ST_IO_CHAIN_MASK
> (1<<  16)
> (reg&  (1<<  16)) == 1
> will ever be true?

good catch. Its should actually be '((reg & (1 << 16)) >> 16) == 1'
This is fixed in the omap4_trigger_io() function, looks like is missed
here.

>

