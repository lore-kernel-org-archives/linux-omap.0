From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] ARM: OMAP: mcbsp: Fix possible memory corruption
Date: Wed, 14 Dec 2011 14:50:09 -0600
Message-ID: <CAB-zwWgkme_SPDMOkT9Xuv2yYdpVAGoNGGRN95vNWh7hb91JSw@mail.gmail.com>
References: <1323678976-4119-1-git-send-email-jarkko.nikula@bitmer.com>
	<1323679106-4191-1-git-send-email-jarkko.nikula@bitmer.com>
	<4EE5D639.8080608@compulab.co.il>
	<4EE5E3F4.6060701@bitmer.com>
	<4EE5EC13.40901@compulab.co.il>
	<20111212183300.GA32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41209 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755364Ab1LNUuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 15:50:10 -0500
Received: by mail-pz0-f43.google.com with SMTP id c6so1580621dae.16
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 12:50:09 -0800 (PST)
In-Reply-To: <20111212183300.GA32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, neilb@suse.de

On Mon, Dec 12, 2011 at 12:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> Applying into fixes.

FWIW, I was bisecting this issue, the patch fixes the following slab
corruptions on boot log:

...
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
Slab corruption: size-32 start=eea66740, len=32
010: d8 9d 02 c0 04 9d 02 c0 6b 6b 6b 6b 6b 6b 6b a5  ........kkkkkkk.
Prev obj: start=eea66720, len=32
000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Next obj: start=eea66760, len=32
000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Slab corruption: size-32 start=eea66740, len=32
010: d8 9d 02 c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  ....kkkkkkkkkkk.
Prev obj: start=eea66720, len=32
000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Next obj: start=eea66760, len=32
000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Slab corruption: size-32 start=eea66740, len=32
010: d8 9d 02 c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  ....kkkkkkkkkkk.
Prev obj: start=eea66720, len=32
000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Next obj: start=eea66760, len=32
000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Slab corruption: size-32 start=eea66740, len=32
010: d8 9d 02 c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  ....kkkkkkkkkkk.
Prev obj: start=eea66720, len=32
000: 6f 6d 61 70 32 5f 6d 63 73 70 69 2e 31 00 5a 5a  omap2_mcspi.1.ZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
Next obj: start=eea66760, len=32
000: 70 6f 77 65 72 00 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  power.ZZZZZZZZZZ
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5  ZZZZZZZZZZZZZZZ.
OMAP DMA hardware revision 0.0
...

Regards,

Omar
