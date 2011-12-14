From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: mcbsp: Fix possible memory corruption
Date: Wed, 14 Dec 2011 13:54:24 -0800
Message-ID: <20111214215424.GO32251@atomide.com>
References: <1323678976-4119-1-git-send-email-jarkko.nikula@bitmer.com>
 <1323679106-4191-1-git-send-email-jarkko.nikula@bitmer.com>
 <4EE5D639.8080608@compulab.co.il>
 <4EE5E3F4.6060701@bitmer.com>
 <4EE5EC13.40901@compulab.co.il>
 <20111212183300.GA32251@atomide.com>
 <CAB-zwWgkme_SPDMOkT9Xuv2yYdpVAGoNGGRN95vNWh7hb91JSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21455 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab1LNVyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 16:54:31 -0500
Content-Disposition: inline
In-Reply-To: <CAB-zwWgkme_SPDMOkT9Xuv2yYdpVAGoNGGRN95vNWh7hb91JSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, neilb@suse.de

* Ramirez Luna, Omar <omar.ramirez@ti.com> [111214 12:18]:
> On Mon, Dec 12, 2011 at 12:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Applying into fixes.
> 
> FWIW, I was bisecting this issue, the patch fixes the following slab
> corruptions on boot log:

Thanks for the info, I've sent the pull request for the two patches
in fixes branch.

Regards,

Tony

 
> hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
> hw-breakpoint: maximum watchpoint size is 4 bytes.
> Slab corruption: size-32 start=eea66740, len=32
> 010: d8 9d 02 c0 04 9d 02 c0 6b 6b 6b 6b 6b 6b 6b a5  ........kkkkkkk.
> Prev obj: start=eea66720, len=32
> 000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Next obj: start=eea66760, len=32
> 000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Slab corruption: size-32 start=eea66740, len=32
> 010: d8 9d 02 c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  ....kkkkkkkkkkk.
> Prev obj: start=eea66720, len=32
> 000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Next obj: start=eea66760, len=32
> 000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Slab corruption: size-32 start=eea66740, len=32
> 010: d8 9d 02 c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  ....kkkkkkkkkkk.
> Prev obj: start=eea66720, len=32
> 000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Next obj: start=eea66760, len=32
> 000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Slab corruption: size-32 start=eea66740, len=32
> 010: d8 9d 02 c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  ....kkkkkkkkkkk.
> Prev obj: start=eea66720, len=32
> 000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> Next obj: start=eea66760, len=32
> 000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
> 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
> OMAP DMA hardware revision 0.0
> ...
> 
> Regards,
> 
> Omar
