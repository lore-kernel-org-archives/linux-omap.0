From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
 	DSP_MMUFAULT
Date: Wed, 12 May 2010 16:09:53 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
 <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32857 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab0ELVKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 17:10:03 -0400
In-Reply-To: <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>



Hi,

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, May 12, 2010 2:39 PM
> To: Guzman Lugo, Fernando
> Cc: Chitriki Rudramuni, Deepak; linux-omap; Ameya Palande; Felipe
> Contreras; Hiroshi Doyu; Ramirez Luna, Omar; Menon, Nishanth
> Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
> DSP_MMUFAULT
> 
> Hi,
> 
> I didn't touch this issue in the hopes that it would be fixed, but
> seems it hasn't.
> 
> On Mon, Apr 19, 2010 at 9:25 PM, Guzman Lugo, Fernando <x0095840@ti.com>
> wrote:
> > To sum up:
> >
> > - "DSPBRIDGE:Fix Kernel memory poison overwritten after DSP_MMUFAULT" is
> only hidden the problem, we don't need aligned memory in this point, that
> patch should be removed if it is already apply.
> >
> > - There is no need to create a patch for the issue because it is already
> indirectly fix with "DSPBRIDGE: MMU-Fault debugging enhancements".
> 
> If you are referring to this patch:
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commit;h=26ad62f03578a12e942d8bb86d0e52ef1afdee22

Yes, that's the patch. Could you make sure that the GPT8 interrupt is generated before acking MMU fault interrupt?

> 
> I tried to backport it to minimize the changes to a reproducible
> test-case. I guess in the l-o branch the commit would be dd1fd0b.
> Unfortunately that didn't fix the corruption. So I don't by that GPT8
> theory.
> 
> > - we don't need allocate memory for dummy_va_addr, if some patch should
> be created should be the patch to remove dummy_va_addr allocation and
> deletion.
> 
> I tried that, and that actually fixes the corruption for me (passing 0
> to hw_mmu_tlb_add).

I think first page DSP side memory is never mapped to MPU side, so even if the DSP corrupts that page it does not affect MPU side. However the right solution is the one explained before: avoid DSP continues executing after MMUfault.

Regards,
Fernando.

> 
> --
> Felipe Contreras
