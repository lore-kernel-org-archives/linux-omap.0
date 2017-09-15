From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: n900 in next-20170901
Date: Fri, 15 Sep 2017 15:28:44 +0200
Message-ID: <20170915132844.GW32278@pali>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170907073038.GA2111@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thursday 07 September 2017 16:30:38 Joonsoo Kim wrote:
> If it doesn't help, is there a way to test n900 configuration in QEMU?

Hi Joonsoo, linaro version of QEMU has support for n900 machine. For
more information how to prepare & run kernel image see this email:
https://lists.denx.de/pipermail/u-boot/2015-January/200171.html
(instead u-boot.bin you would supply kernel's zImage)

But QEMU does not support HS mode, so there is probably no secure ram.
IIRC smc instructions should not be used in normal GP mode.

-- 
Pali Rohár
pali.rohar@gmail.com
