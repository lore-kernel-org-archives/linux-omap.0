From: Rok =?utf-8?q?Markovi=C4=8D?= <rok@kanardia.eu>
Subject: Asoc with TWL4030 on overo
Date: Thu, 18 Mar 2010 08:23:55 +0100
Message-ID: <201003180823.55248.rok@kanardia.eu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-12.siol.net ([193.189.160.138]:54749 "EHLO mta-12.siol.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab0CRJrv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 05:47:51 -0400
Received: from mail-8.siol.net ([10.10.10.138]) by mta-14.siol.net
          with ESMTP
          id <20100318072358.XKRA5102.mta-14.siol.net@mail-8.siol.net>
          for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 08:23:58 +0100
Received: from rok.localnet ([193.77.104.223]) by mail-8.siol.net
          with ESMTP
          id <20100318072413.CBSQ18015.mail-8.siol.net@rok.localnet>
          for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 08:24:13 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

I am trying to play sound on overo board. With latest kernel I cannot g=
et=20
any sound, while with kernel 2.6.33-rc6-07400-ga05966f-dirty sound is=20
played by ALSA correctly. I am using ALSA 1.0.22 with asound.conf like=20
this:=20
pcm.dsp0 {
    type plug
        slave.pcm "dmix"
}

ctl.mixer0 {
    type hw
        card 0
}

With both kernels I get the same output, and when I execute aplay or=20
amixer everything looks correctly.

Kernel output:
cpuidle: using governor menu
No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4
overo SoC init
asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok
ALSA device list:
  #0: overo (twl4030)



# cat /proc/asound/cards=20
 0 [overo          ]: twl4030 - overo
                      overo (twl4030)


# cat /proc/asound/devices=20
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

Regards,
Rok



--=20
Rok Markovi=C4=8D
Kanardia d.o.o.
Ul. heroja Roj=C5=A1ka 70
SI-3000 Celje

Tel: +386 40 360 963
=46ax: +386 590 11 416
E-mail: rok.markovic@kanardia.eu
URL: www.kanardia.eu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
