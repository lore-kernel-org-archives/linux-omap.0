From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bunch of CRC errors in next with arm: move exports to definitions
Date: Thu, 20 Oct 2016 06:24:48 -0700
Message-ID: <20161020132448.zq76j644ezhunc5r@atomide.com>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
 <6218660.zgecHdOkUb@wuerfel>
 <20161018093628.GE5783@n2100.arm.linux.org.uk>
 <5893445.41LAZjK8v5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5893445.41LAZjK8v5@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, Sebastian Reichel <sre@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [161018 03:02]:
> On Tuesday, October 18, 2016 10:36:28 AM CEST Russell King - ARM Linux wrote:
> > On Tue, Oct 18, 2016 at 11:13:31AM +0200, Arnd Bergmann wrote:
> > > On Tuesday, October 18, 2016 6:59:44 AM CEST Sebastian Reichel wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Aug 22, 2016 at 09:25:13AM -0700, Tony Lindgren wrote:
> > > > > Looks like starting with next-20160818 I'm now getting close to
> > > > > 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> > > > > make modules:
> > > > > 
> > > > > Building modules, stage 2.
> > > > >   MODPOST 399 modules
> > > > > WARNING: "__memzero" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "__aeabi_uidivmod" [sound/usb/snd-usb-audio.ko] has no CRC!
> > > > > WARNING: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] has no CRC!
> > > > > WARNING: "arm_copy_to_user" [sound/usb/snd-usb-audio.ko] has no CRC!
> > > > > WARNING: "__aeabi_uidiv" [sound/usb/snd-usb-audio.ko] has no CRC!
> > > > > ...
> > > > > WARNING: "memset" [crypto/drbg.ko] has no CRC!
> > > > > WARNING: "memcpy" [crypto/ctr.ko] has no CRC!
> > > > > WARNING: "memcpy" [crypto/cmac.ko] has no CRC!
> > > > > WARNING: "__memzero" [crypto/cmac.ko] has no CRC!
> > > > > WARNING: "memcpy" [crypto/ccm.ko] has no CRC!
> > > > > WARNING: "__memzero" [crypto/ccm.ko] has no CRC!
> > > > 
> > > > Any update on this one? I just updated my power-supply next branch
> > > > to v4.9-rc1 and now get almost 18000 CRC warnings for allmodconfig.
> > > > (I use arm-linux-gnueabihf-gcc (Debian 6.1.1-9) 6.1.1 20160705)
> > > 
> > > Nick did a patch to fix this in general, and in powerpc specifically,
> > > I sent a patch yesterday to fix the ARM specific symbols.
> > 
> > Did you now?  You failed to _at least_ copy me on that.  This is clearly
> > about core ARM code and not arm-soc stuff, you should always copy me on
> > such changes, and if I were Lee Jones, I'd insist that it was merged
> > through my tree.
> 
> Right, sorry for missing the Cc, this was one of many build-time
> bugfix patches I sent out recently.
> 
> Nick's patch is still under discussion on linux-arch, and my patch
> is part of that discussion, but of course you should have been
> included in the discussion as well.

For reference, that thread seems to be at:

http://lkml.org/lkml/2016/10/19/221

Tony
