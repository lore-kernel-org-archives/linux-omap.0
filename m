From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] OMAP: DMA: Cleanup of DMA Request Lines
Date: Mon, 10 Dec 2007 10:25:08 -0800
Message-ID: <20071210182507.GE19104@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804FE689E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804FE689E@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [071209 20:16]:
> Hi all,
> 
> I'm resending this patch with the #else removed. I'm also sending a few
> other ways in which we could do this.
> 
> Option 1:
> Same patch as the last time without the #else
> 
> This contains lots of #ifdef statements but there are no #elses

Yeah, not good..

> Option 2:
> No #ifdefs.
>
> Using OMAP242X_* for 2420 specific names
> OMAP243X_* for 2430 specific names/names present from 243X onwards
> OMAP24XX_* for names common to all 24XX, 34XX
> OMAP34XX_* for 34XX specific names
> 
> (or something similar could be worked out)

This is better on short term. It needs an associated patch to change
drivers to use new names.

> Option 3:
> 
> Name all possible names OMAP_* (or OMAP2_*) and use a runtime check to return
> the correct request line number.
> 
> I'm sending sample patches for all three options. Let me know what you think.

Hey, this looks like a good solution in the long run. Except, let's just
load the table for each processor that is compiled in to save memory.

You could load the associated processor dma request configuration from
devices_2420.c, devices_2430.c and devices_3430.c.

Regards,

Tony
