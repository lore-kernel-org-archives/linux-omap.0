From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Mon, 18 Sep 2017 11:07:17 +0900
Message-ID: <20170918020716.GB19200@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170915132844.GW32278@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915132844.GW32278@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hello,

On Fri, Sep 15, 2017 at 03:28:44PM +0200, Pali Rohár wrote:
> On Thursday 07 September 2017 16:30:38 Joonsoo Kim wrote:
> > If it doesn't help, is there a way to test n900 configuration in QEMU?
> 
> Hi Joonsoo, linaro version of QEMU has support for n900 machine. For
> more information how to prepare & run kernel image see this email:
> https://lists.denx.de/pipermail/u-boot/2015-January/200171.html
> (instead u-boot.bin you would supply kernel's zImage)

I tried to search to download required tools but cannot find a qflasher.
Looks like you have qflasher and other *.bin for n900 image.
Could you share them to me, please?

> But QEMU does not support HS mode, so there is probably no secure ram.
> IIRC smc instructions should not be used in normal GP mode.

Okay. Thanks for information. I'm not sure that I can regenerate the
error with n900 QEMU emulation but that would be my best so I will
try.

Thanks.
