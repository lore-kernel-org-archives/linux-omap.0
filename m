From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
Date: Sat, 13 Jun 2009 13:57:44 +1200
Message-ID: <5a7b8b7b0906121857q32f0fd2ckdca5fb1ea776ceec@mail.gmail.com>
References: <5a7b8b7b0906101913h2dbcbbc6l8f27873b8f81a3e0@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5345DB6@dbde02.ent.ti.com>
	 <5a7b8b7b0906102035s448e33cfpe4b321d36288e514@mail.gmail.com>
	 <1244700526.9815.31.camel@blitz>
	 <5910F919-941B-4964-99F5-C5772B1965C9@gmail.com>
	 <6ed0b2680906110229u7ce2481sddb0168829bf7d38@mail.gmail.com>
	 <8CD1B7D1-9B84-45C1-BC91-B44839743500@gmail.com>
	 <4A3202FF.9080201@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:6754 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZFMB5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 21:57:42 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1743718ywb.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 18:57:44 -0700 (PDT)
In-Reply-To: <4A3202FF.9080201@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

Thanks for that. These don't help specifically with my problem, but
are none-the-less valuable, and seem to make MMC more reliable when
the system is heavily loaded.

On Fri, Jun 12, 2009 at 7:25 PM, Adrian Hunter<adrian.hunter@nokia.com> wrote:
<snip>
> We have fixed a few bugs in omap_hsmmc.c that we have not had time
> to send to mainline, but will hopefully in the coming weeks.
>
> I have attached some patches which probably do not apply cleanly,
> and may not help with your problem anyway.
>
