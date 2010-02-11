From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Prevent memory corruption in
 DRV_ProcFreeDMMRes
Date: Thu, 11 Feb 2010 20:44:05 +0200
Message-ID: <1265913845.26446.3.camel@sanganak>
References: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
	 <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602AA725BDE@dlee06.ent.ti.com>
	 <94a0d4531002091548n18897915kd236f9f7b332c1eb@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602AA725D82@dlee06.ent.ti.com>
	 <20100210130759.GC9214@annwn.felipec.org>
	 <496565EC904933469F292DDA3F1663E602AA725F61@dlee06.ent.ti.com>
	 <20100211155322.GE4673@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17081 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785Ab0BKSop (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:44:45 -0500
In-Reply-To: <20100211155322.GE4673@annwn.felipec.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>
Cc: "ext Guzman Lugo, Fernando" <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>

Hi all,

On Thu, 2010-02-11 at 16:53 +0100, Contreras Felipe (Nokia-D/Helsinki)
wrote:
> On Wed, Feb 10, 2010 at 06:31:35PM +0100, ext Guzman Lugo, Fernando wrote:
> > >-----Original Message-----
> > >From: Felipe Contreras [mailto:felipe.contreras@nokia.com]
> > >> Resource cleanup does not support that even without my proposed changes.
> > >
> > >Aha! I suspected it :P
> > >
> > Resource cleanup does not support that because it tries to unreserved
> > every chunk mapped. However it does not means the dspbridge does not
> > support reserving a big chunk of memory and mapping small parts of
> > that memory, but I have not tested it to confirm if it works.
> 
> I think I did once and it didn't work, but I thought the problem was in
> my app. Anyway I think we should either forget about this use-case or
> fix the resource cleaning.
> 
> > >> I just proposed a solution which fixes two issues in one patch.
> > >> Moreover if this change is merged when the second issue be fixed this
> > >> patch will not needed anymore, so why don't merge the patch which
> > >> fixes both errors at this moment?
> > >
> > >simple patches > complicated patches
> > The patch is more simple than it looks.
> 
> Only one way to know :)
> 
> > >Personally I think your patches should be a continuation to the patches
> > >I just proposed.
> > Yes, I think it would be better.
> 
> Cool.
> 

Thanks for reviewing the patch!

After going through your comments I feel the current patch is inadequate
to do proper resource cleanup :(

I am working on something which should take care of map and reserve
both. Basically I am working on separating current DMM resource
accounting for map and reserve, which should fix all the problems. Will
post the patchset soon!

Cheers,
Ameya.

