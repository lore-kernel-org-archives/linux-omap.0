From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] Keyboard: omap-keypad: use matrix_keypad.h
Date: Mon, 20 Dec 2010 21:21:45 +0100
Message-ID: <201012202121.47976.jkrzyszt@tis.icnet.pl>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <201012201832.24243.jkrzyszt@tis.icnet.pl> <BC214410FD04D84F9079A624236597070C1680@008-AM1MPN1-003.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <BC214410FD04D84F9079A624236597070C1680@008-AM1MPN1-003.mgdnok.nokia.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: aaro.koskinen@nokia.com
Cc: dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Monday 20 December 2010 20:03:58 aaro.koskinen@nokia.com wrote:
>
> I'm using the latest sparse from:
>
>    git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>
> I don't know about OpenEmbedded, but I've noticed that at least
> Debian ships with some old version that is missing many checks...

Aaro,
Both you and Dmitry were right: an old sparse version. Once upgraded 
from 0.4.1 to 0.4.2 (Gentoo ebuild - OpenEmbedded doesn't build its own 
sparse binary, but uses a host provided one), now I get that issue 
reported. No more sparse warnings from me, I hope (until my sparse gets 
too old again ;).

Thanks,
Janusz
