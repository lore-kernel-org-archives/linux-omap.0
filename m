From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 0/5] DSPBRIDGE: patches.
Date: Thu, 5 Mar 2009 09:10:16 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23080CE9@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287B84DB4@dlee06.ent.ti.com>
	 <269694c00903050226q5c9328b6t94545fc8897f0c8f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E22FE718B@dlee03.ent.ti.com>
 <94a0d4530903050542r39af0220l1b7a4117089e37df@mail.gmail.com>
 <8F7AF80515AF0D4D93307E594F3CB40E22FE71D3@dlee03.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF350111@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55647 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZCEPKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 10:10:30 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF350111@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ameya Palande <2ameya@gmail.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> Ok, so we have:
> a) omapzoom bridge
> b) linux omap bridge
> 
> Impertinent question: what are our plans b/w these two?
> 

A. omapzoom bridge -- As far as I know, this will be the master tree for the DSPBridge code. The Bridge patches will be based on this tree. I think it was already communicated some time ago that the linux-omap mailing list will be used for Bridge discussions and for sending the Bridge patches to OMAPZOOM. There is no separate mailing list for omapzoom.

B. linux omap bridge -- I think this tree is maintained by Hiroshi by merging the patches that are sent to OMAPZOOM tree. The only difference that should be between the omapzoom tree and linux omap tree is the Power management. Omapzoom Bridge uses T.I Power management, where as the linux omap Bridge uses open source Power management. So, any patches related to open source power manaegment will be based on linux omap tree. The maintainer of linux omap Bridge tree should sync up the Bridge changes from the omapzoom tree.


Thank you,
Best regards,
Hari
 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, March 05, 2009 8:05 AM
> To: Kanigeri, Hari; Felipe Contreras
> Cc: Ameya Palande; Guzman Lugo, Fernando; Hiroshi DOYU; 
> linux-omap@vger.kernel.org
> Subject: RE: [PATCH 0/5] DSPBRIDGE: patches.
> 
> Hi Hari,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> > owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> > Sent: Thursday, March 05, 2009 3:52 PM
> > To: Felipe Contreras
> > Cc: Ameya Palande; Guzman Lugo, Fernando; Hiroshi DOYU; linux- 
> > omap@vger.kernel.org
> > Subject: RE: [PATCH 0/5] DSPBRIDGE: patches.
> > > We are in linux-omap, not omapzoom, and this is the tidspbridge 
> > > branch in linux-omap:
> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.
> > 6.git;a=shortlog;h=tidspbridge
> > >
> > > I'm sure you don't want to increase the discrepancy between 
> > > linux-omap and omapzoom, so the patches sent to l-o 
> should apply on 
> > > top of the l-o tidspbridge in order to be merged.
> > 
> > -- I am sorry, as of now the Bridge patches will be based only on 
> > omapzoom tree.
> 
> Ok, so we have:
> a) omapzoom bridge
> b) linux omap bridge
> 
> Impertinent question: what are our plans b/w these two?
> 
> Regards,
> Nishanth Menon
> 