From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/5] OMAP4: crypto support
Date: Wed, 14 Jun 2017 00:57:51 -0700
Message-ID: <20170614075750.GG3730@atomide.com>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
 <ab778bfd-9397-4cb0-0741-557da57bba83@ti.com>
 <20170613142458.32g3iqcijc4ij4b7@earth>
 <027b40b6-1961-275b-7b7e-00a51e86e8f3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <027b40b6-1961-275b-7b7e-00a51e86e8f3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170613 07:46]:
> On 13/06/17 17:24, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Tue, Jun 13, 2017 at 04:49:18PM +0300, Tero Kristo wrote:
> > > On 13/06/17 12:28, Sebastian Reichel wrote:
> > > > This adds crypto support for OMAP4, which was missing for some reason.
> > > > This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
> > > > DES are working according to selftest.
> > > > 
> > > > Changes since PATCHv1:
> > > >    * remove patch adding des_fck to DT
> > > >    * add patch removing aes[12]_fck from DT
> > > >    * add patch renaming hwmod aes to aes1 in DT
> > > >    * update hwmod patches according to feedback from Tero
> > > >    * add patch for aes2 hwmod
> > > > 
> > > > -- Sebastian
> > > 
> > > I just posted a few extra patches on top of this series, for adding
> > > the missing dts data for aes2 and adding sham accelerator also.
> > 
> > Thanks :)
> > 
> > > The dts data should be applied first if you want to avoid any
> > > issues with hwmod core complaining about missing DT data, so the
> > > sequencing of this series and mine need to be done carefully.
> > 
> > There is also a warning printed if DT references a missing hwmod
> > entry (that's how I noticed this in the first place). It's less
> > noisy, though. Since kernel builds and boots with any order and
> > crypto hardware does not work at the moment there is no real
> > problem with bisect. I suggest to merge the DTS patches normally
> > through the separate dt branch.
> 
> Yeah thats actually true also. Up to Tony to decide how he wants to handle
> these. The huge warning is mainly an annoyance.

Applying patches from both Sebastian's and Tero's sets into
split into omap-for-v4.13/dt and omap-for-v4.13/soc-v4 branches.

Thanks,

Tony
