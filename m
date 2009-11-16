From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: Some patches need reposting, inbox cleared, patchwork cleared
Date: Mon, 16 Nov 2009 17:07:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8C3A@dbde02.ent.ti.com>
References: <20091113003851.GN24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8605@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C860A@dbde02.ent.ti.com>
 <20091113180323.GC3684@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689287@dbde02.ent.ti.com>
 <20091113181550.GD3684@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689291@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA6892A1@dbde02.ent.ti.com>
 <20091114010800.GK3684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45893 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbZKPLhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 06:37:48 -0500
In-Reply-To: <20091114010800.GK3684@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, November 14, 2009 6:38 AM
> To: Pandita, Vikram
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Some patches need reposting, inbox cleared, patchwork cleared
> 
> * Pandita, Vikram <vikram.pandita@ti.com> [091113 11:06]:
> > Tony
> >
> > >-----Original Message-----
> > >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> > >Pandita, Vikram
> > >>From: Tony Lindgren [mailto:tony@atomide.com]
> > >>> I just verified booting zoom3 on l-o master, and its working fine.
> > >>
> > >>OK good. Can you also try booting this patch from Felipe on 3630:
> > >>
> > >>http://patchwork.kernel.org/patch/59540/
> > >
> > >Patch does not apply. Rebasing now and testing.
> >
> > Rebased Patch (attached) boots up fine now on 3630 Zoom3 board.
> >
> > Logs:
> > CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
> > CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> > Machine: OMAP Zoom3 board
> > Memory policy: ECC disabled, Data cache writeback
> > OMAP3630 ES1.0 (l2cache iva sgx neon isp )
> >
> 
> OK, thanks applying it.
Tony,

I am not able to see the following patch in the list:

OMAP3EVM: Use the twl4030_setup_data for headset pop-removal
http://marc.info/?l=linux-omap&m=125368984011630&w=2

Can you apply it please?
> 
> Tony
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

