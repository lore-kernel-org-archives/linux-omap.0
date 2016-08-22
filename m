From: Tony Lindgren <tony@atomide.com>
Subject: Bunch of CRC errors in next with arm: move exports to definitions
Date: Mon, 22 Aug 2016 09:25:13 -0700
Message-ID: <20160822162512.mptzbiaozx2fz42l@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Al,

Looks like starting with next-20160818 I'm now getting close to
800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
make modules:

Building modules, stage 2.
  MODPOST 399 modules
WARNING: "__memzero" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "__aeabi_uidivmod" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "arm_copy_to_user" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "__aeabi_uidiv" [sound/usb/snd-usb-audio.ko] has no CRC!
...
WARNING: "memset" [crypto/drbg.ko] has no CRC!
WARNING: "memcpy" [crypto/ctr.ko] has no CRC!
WARNING: "memcpy" [crypto/cmac.ko] has no CRC!
WARNING: "__memzero" [crypto/cmac.ko] has no CRC!
WARNING: "memcpy" [crypto/ccm.ko] has no CRC!
WARNING: "__memzero" [crypto/ccm.ko] has no CRC!

Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
fixes it.

Regards,

Tony
