From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] cpsw: Fix interrupt storm among other things
Date: Mon, 28 Jan 2013 20:40:25 +0200
Message-ID: <4E26978C-0B09-4E06-8373-49F1850C08C4@antoniou-consulting.com>
References: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com> <20130128182451.GC2445@netboy.at.omicron.at>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130128182451.GC2445@netboy.at.omicron.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Matt Porter <mporter@ti.com>, Chase Maupin <chase.maupin@ti.com>, Jason Kridner <jdk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Richard,

Yes, I guess this was more of a drive-by patch dump - but people need this
to get PG2.0 silicon to work on am33xx.
 
On Jan 28, 2013, at 8:24 PM, Richard Cochran wrote:

> On Mon, Jan 28, 2013 at 03:11:08PM +0200, Pantelis Antoniou wrote:
>> Fix interrupt storm on bone A4 cause by non-by-the-book interrupt handling.
>> While at it, added a non-NAPI mode (which is easier to debug), plus
>> some general fixes.
> 
> I have a few issues with this patch:
> 
> 1. This is a networking patch. It should be addressed to netdev, it it
>   needs to have davem on CC.
> 
> 2. The description is poor. You need to tell us more about this
>   "storm". How can one trigger it? What is the effect? Does the
>   system lock up, or is the throughput poor? Tell us exactly what the
>   problem is. Tell us what is wrong in the interrupt handling, and
>   how the patch improves the situation.
> 

PG2.0 fixed a number of silicon bugs. The old driver hard locked, since
it didn't follow the TRM described interrupt handling.

> 3. Don't just say "general fixes", but do say exactly what you fixed.
> 
> 4. Adding non-NAPI code is going backwards. Don't do that (and see the
>   recent discussion on netdev on just this very topic: Frank Li and
>   the fec driver).
> 

Speaking of which, I'm probably the original developer of the fec driver.

And no, I don't think having a non-NAPI code path is backwards, especially
when trying to debug hardware problems; the non-NAPI driver is much easier
to understand and follow, especially when there is a convoluted method
you have to follow to have the h/w acknowledge the interrupt.
Not every device can be conveniently be made to shut up so that NAPI processing 
can take place at a later time.

The NAPI case is still broken in this driver, which OOPs under load.

>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 40aff68..b6ca4af 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -148,10 +148,37 @@ struct cpsw_wr_regs {
>> 	u32	soft_reset;
>> 	u32	control;
>> 	u32	int_control;
>> -	u32	rx_thresh_en;
>> -	u32	rx_en;
>> -	u32	tx_en;
>> -	u32	misc_en;
>> +	u32	c0_rx_thresh_en;
>> +	u32	c0_rx_en;
>> +	u32	c0_tx_en;
>> +	u32	c0_misc_en;
> 
> How does renaming these help?
> 
> (If you really think that new names are needed, then put the cosmetic
> renaming changes into its a separate patch.)

Those are the real register names in the updated TRM.

> 
>> +	u32	c1_rx_thresh_en;
>> +	u32	c1_rx_en;
>> +	u32	c1_tx_en;
>> +	u32	c1_misc_en;
> 
> You added a bunch of new fields, but you don't use any of them.
> 

dido.

> Thanks,
> Richard

Regards

-- Pantelis
