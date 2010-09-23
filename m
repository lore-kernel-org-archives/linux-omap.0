From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC] omap: mailbox: fix detection for previously supported
 chips
Date: Thu, 23 Sep 2010 11:50:00 -0500
Message-ID: <A24693684029E5489D1D202277BE894472802DDC@dlee02.ent.ti.com>
References: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
 <A24693684029E5489D1D202277BE894472802A7F@dlee02.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A530450E3FBEF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37480 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139Ab0IWQuF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 12:50:05 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530450E3FBEF@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Anna, Suman" <s-a>

Hi Omar,

> -----Original Message-----
> From: Ramirez Luna, Omar
> Sent: Thursday, September 23, 2010 11:12 AM
> To: Aguirre, Sergio; Tony Lindgren; Hiroshi DOYU; Felipe Contreras; Anna,
> Suman; linux-omap@vger.kernel.org
> Subject: RE: [RFC] omap: mailbox: fix detection for previously supported
> chips
> 
> Hi Sergio,
> 
> Aguirre, Sergio wrote:
> > Hi Omar,
> >>
> ...
> >> +#if defined(CONFIG_ARCH_OMAP2)
> >> +	else if (cpu_is_omap2430()) {
> >> +		list = omap2_mboxes;
> >> +
> >> +		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
> >> +	} else if (cpu_is_omap2420()) {
> >
> > Isn't both 2430 and 2420 doing the exact same?
> >
> 
> Code is not the same, it is 2 line which apply for both but couldn't find
> an easy way of making them share the request for dsp mailbox without
> changing more code, perhaps a macro to detect if omap2 and then a nested
> if for the 2420 case, but since HWMOD should handle it better, I left it
> as is.
> 
> As the code previous to reorganization treated 2430 has a user with one
> single mailbox (same as omap3) I added the code to at least detect it,
> 2420 has 2 mailboxes one for iva and other for the dsp. From the diagrams
> for OMAP2430[1] and OMAP2420[2], it made sense as in the later both dsp
> and iva seem to be separated entities; unfortunately I don't have the
> hardware to test on any of them.
> 
> The patched code should look like:
> 
> #if defined(CONFIG_ARCH_OMAP2)
>         else if (cpu_is_omap2430()) {
>                 list = omap2_mboxes;
> 
>                 list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>         } else if (cpu_is_omap2420()) {
>                 list = omap2_mboxes;
> 
>                 list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>                 list[1]->irq = platform_get_irq_byname(pdev, "iva");
>         }
> #endif

Ok, I understand.

I guess I missed to see the second element in the list for acquiring IVA irq.

Thanks for the explanation.

Regards,
Sergio

> 
> Regards,
> 
> Omar
> 
> ---
> 
> [1]
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?contentId=467
> 2&navigationId=12609&templateId=6123
> [2]
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=61
> 23&navigationId=11990&contentId=4671
