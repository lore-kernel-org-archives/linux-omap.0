From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
 disabled
Date: Fri, 3 Dec 2010 18:10:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012031807440.17078@utopia.booyaka.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com> <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com> <alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com> <AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
 <alpine.DEB.2.00.1012020022390.2515@utopia.booyaka.com> <AANLkTi=hiwspQ4hM0Ok+MHjn5iHme4XRTKZPGa0Z2=Xy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-921073587-1291425049=:17078"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43941 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab0LDBKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 20:10:52 -0500
In-Reply-To: <AANLkTi=hiwspQ4hM0Ok+MHjn5iHme4XRTKZPGa0Z2=Xy@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-921073587-1291425049=:17078
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Salut Jean

On Thu, 2 Dec 2010, Jean Pihet wrote:

> On Thu, Dec 2, 2010 at 8:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 25 Nov 2010, Jean Pihet wrote:
> >> On Thu, Nov 25, 2010 at 6:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > On Thu, 25 Nov 2010, Jean Pihet wrote:
> >> >> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wr=
ote:
> >> >> >
> >> >> > The console semaphore must be held while the OMAP UART devices ar=
e
> >> >> > disabled, lest a console write cause an ARM abort (and a kernel c=
rash)
> >> >> > when the underlying console device is inaccessible. =A0These cras=
hes
> >> >> > only occur when the console is on one of the OMAP internal serial
> >> >> > ports.
> >> >> This does not fix the issue for me on Beagle (console on ttyO2).
> >> >>
> >> >> Doing:
> >> >> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_tim=
eout
> >> >> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_tim=
eout
> >> >> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_tim=
eout
> >> >> and waiting 5 seconds hangs the console.
> >> >
> >> > By the way, you write that the above situation "hangs the console." =
=A0Is it
> >> > just the case that the console dies and the rest of the system is st=
ill
> >> > alive, or does the whole system crash?
> >> The console hangs, the rest of the system still runs.
> >
> > Just out of curiosity, if you send a few breaks to the OMAP over serial=
,
> > does that cause the console to pay attention again? =A0CTRL-A F in mini=
com.
> Yes it helps. In most cases sending 2-3 breaks resumes the UART console.

Could you try enabling DSS in your .config?  I applied the following to my=
=20
omap2plus_defconfig after make oldnoconfig, and the console is now working=
=20
again for me.

Hopefully adding DSS hwmod stuff will fix this...


- Paul

--- .config=092010-12-03 18:05:31.661889255 -0700
+++ .config.sleep.working=092010-12-03 18:03:57.733918058 -0700
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux/arm 2.6.37-rc4 Kernel Configuration
-# Fri Dec  3 18:05:31 2010
+# Fri Dec  3 18:00:21 2010
 #
 CONFIG_ARM=3Dy
 CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
@@ -1465,9 +1465,28 @@
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-# CONFIG_FB_OMAP is not set
 CONFIG_FB_OMAP_LCD_VGA=3Dy
-# CONFIG_OMAP2_DSS is not set
+CONFIG_OMAP2_DSS=3Dy
+CONFIG_OMAP2_VRAM_SIZE=3D0
+CONFIG_OMAP2_DSS_DEBUG_SUPPORT=3Dy
+# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
+CONFIG_OMAP2_DSS_DPI=3Dy
+# CONFIG_OMAP2_DSS_RFBI is not set
+CONFIG_OMAP2_DSS_VENC=3Dy
+# CONFIG_OMAP2_DSS_SDI is not set
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=3D0
+# CONFIG_FB_OMAP2 is not set
+
+#
+# OMAP2/3 Display Device Drivers
+#
+# CONFIG_PANEL_GENERIC is not set
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+# CONFIG_PANEL_SHARP_LQ043T1DG01 is not set
+# CONFIG_PANEL_TOPPOLY_TDO35S is not set
+# CONFIG_PANEL_TPO_TD043MTEA1 is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
 CONFIG_LCD_CLASS_DEVICE=3Dy
 # CONFIG_LCD_L4F00242T03 is not set
--155748971-921073587-1291425049=:17078--
