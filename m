From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCHv4 4/4] DSPBRIDGE: Improved mapped memory cleanup
Date: Thu, 18 Feb 2010 16:27:28 +0200
Message-ID: <20100218142728.GD4097@annwn.felipec.org>
References: <cover.1266429436.git.ameya.palande@nokia.com>
 <f57155cbfa5cca493333eff553f6887217273a3b.1266429437.git.ameya.palande@nokia.com>
 <496565EC904933469F292DDA3F1663E602CA2B9AD9@dlee06.ent.ti.com>
 <1266495355.2105.5.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32433 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0BRO1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:27:42 -0500
Content-Disposition: inline
In-Reply-To: <1266495355.2105.5.camel@sanganak>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Cc: "ext Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

On Thu, Feb 18, 2010 at 01:15:55PM +0100, Ameya Palande wrote:
> On Thu, 2010-02-18 at 02:52 +0100, ext Guzman Lugo, Fernando wrote:
> > What do you think about it?
> > Instead of removing DRV_InsertDMMResElement make it an inline function with your code inside:
> 
> Making DRV_InsertDMMResElement inline doesn't make sense since we are
> not calling it multiple times.

I agree with Fernando; the code would be more readable. Even more if we
rename the function to instert_map_element().

note: should be 'static inline'

> > inline void DRV_InsertDMMResElement(u32 ppMapAddr)
> > {
> >         map_obj = kmalloc(sizeof(struct DMM_MAP_OBJECT), GFP_KERNEL);
> >         if (map_obj) {
> >                 map_obj->dsp_addr = (u32)*ppMapAddr;
> >                 spin_lock(&pr_ctxt->dmm_map_lock);
> >                 list_add(&map_obj->link, &pr_ctxt->dmm_map_list);
> >                 spin_unlock(&pr_ctxt->dmm_map_lock);
> >         }
> > }
> > 
> > It could make the code more understandable about what it is actually doing.
> > It also applies to the functions which removes this patch.
> 
> I can put a comment here to clarify what this code is doing ;)

AFAIK in linux, self-documenting code is preferred over comments.

Cheers.

-- 
Felipe Contreras
