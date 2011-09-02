From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular
	board
Date: Fri, 2 Sep 2011 10:59:54 +0200
Message-ID: <4E609B0A.1020804@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-8-git-send-email-b-cousson@ti.com>
	<20110902081246.GQ3548@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110902081246.GQ3548@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/2/2011 10:12 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [110901 19:52]:
>> In order to avoid conflict with the new board-omap3-dt.c file,
>> remove the .dt_compat entry from the beagle regular board
>> file.
>>
>> Any DT work for OMAP3 will have to be done on the generic DT
>> board file to avoid breaking the legacy board support until
>> DT migration is done.
>
> In general we should not keep duplicate old non-DT data around
> now that we have the DT append support. Instead we should just
> require the .dts file appended to zImage for all mach-omap2
> machines. Otherwise we'll end up with double bloat :)

Mmm, I'm not sure to get your point. We are not duplicating, since a 
pure DT generic board will not have anything except a 
of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
And the regular board files will keep initializing devices statically.
The drivers will then for the moment support both pdata and DT method to 
get board parameters.

> So it's OK to have the DT entries in board files so drivers
> that get converted will work with them.

Well, it will be a little bit more tricky, because having DT in current 
board files will be a mess with a bunch of #ifdef CONFIG_OF, and adding 
DT compatible inside each boards will prevent the pure generic DT one to 
work. In that case we will duplicate the DT migration in every legacy 
boards files...

That's why the current strategy is to keep the current board files 
non-DT aware and add the DT support only to the generic DT board file.

Regards,
Benoit
