From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 01/22] gpio/omap: remove dependency on gpio_bank_count
Date: Mon, 29 Aug 2011 17:48:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0384F03245@dbde02.ent.ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
 <1312455893-14922-2-git-send-email-tarun.kanti@ti.com>
 <4E539E95.2080807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab1H2MS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 08:18:29 -0400
In-Reply-To: <4E539E95.2080807@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
> >   void omap2_gpio_prepare_for_idle(int off_mode)
> >   {
> > -	int i, c = 0;
> > -	int min = 0;
> > -
> > -	if (cpu_is_omap34xx())
> > -		min = 1;
> > +	int c = 0;
> > +	struct gpio_bank *bank;
> >
> > -	for (i = min; i<  gpio_bank_count; i++) {
> > -		struct gpio_bank *bank =&gpio_bank[i];
> > +	list_for_each_entry(bank,&omap_gpio_list, node) {
> >   		u32 l1 = 0, l2 = 0;
> >   		int j;
> >
> > +		/* TODO: Do not use cpu_is_omap34xx */
> 
> Is this addressed in subsequent patches ?
Yes.
--
Tarun
> 
> > +		if ((cpu_is_omap34xx())&&  (bank->id == 0))
> > +			continue;
> > +
> 
> Rest of the changes looks good to me.
> After you answer above, you can add my,
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Regards
> Santosh
