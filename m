From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Mon, 5 Nov 2012 03:15:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211050313130.23228@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <20121025101212.GD21217@arwen.pp.htv.fi> <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com> <20121029200032.GD30152@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com> <20121030123254.GD29095@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
 <20121030125419.GG29095@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com> <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com> <87fw4u3oh5.fsf@deeprootsystems.com> <CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
 <alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com> <CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com> <CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36511 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab2KEDPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 22:15:17 -0500
In-Reply-To: <CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jean,

On Sat, 3 Nov 2012, Jean Pihet wrote:

> The setup is as identical as possible to yours:
> - U-Boot 2011.06-dirty (Sep 04 2012 - 17:06:58) from
> http://www.pwsan.com/tmp/3530es3beagle-MLO-u-boot-20121023.tar.bz2.
>   Please note that the MLO image does not run on my board and so I had
> to use my known-to-work image.

Interesting...

> The result is that I could reproduce the issue but it happens much
> more rarely on my side (only once vs quasi 100% on ~50 boot cycles).

Hmm...

> The issue is triggered by running 'hwclock --systohc'  while the
> system is heavily loaded (running depmod etc.).

OK.

> More investigation on-going, so more to come!

Great, keep us posted.

Will try to kick off those tests you requested within the next 24-48 
hours.


- Paul
