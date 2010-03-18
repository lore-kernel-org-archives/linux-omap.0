From: Rok =?utf-8?q?Markovi=C4=8D?= <rok@kanardia.eu>
Subject: Re: Asoc with TWL4030 on overo
Date: Thu, 18 Mar 2010 15:52:00 +0100
Message-ID: <201003181552.00203.rok@kanardia.eu>
References: <201003180823.55248.rok@kanardia.eu> <20100318164002.70c710a3.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-14.siol.net ([193.189.160.142]:57185 "EHLO mta-14.siol.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab0CROwG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 10:52:06 -0400
In-Reply-To: <20100318164002.70c710a3.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

Yes muted sound was the culprit. :), why does not kernel enable sound b=
y=20
default and why are there so many mixer controls.

Rok


Dne =C4=8Detrtek 18 marca 2010 ob 15:40:02 je Jarkko Nikula napisal(a):
> Hi
>=20
> On Thu, 18 Mar 2010 08:23:55 +0100
>=20
> Rok Markovi=C4=8D <rok@kanardia.eu> wrote:
> > I am trying to play sound on overo board. With latest kernel I cann=
ot
> > get any sound, while with kernel 2.6.33-rc6-07400-ga05966f-dirty
> > sound is played by ALSA correctly. I am using ALSA 1.0.22 with
> > asound.conf like
>=20
> Beagle plays fine on linux-omap head. One reason could be the patch
> below as it requires that the user space must activate the headset
> output path by proper mixer settings.
>=20
> commit e47c796d58a21fc58b00dffb7265bb66de987773
> Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Date:   Wed Feb 17 09:49:54 2010 +0200
>=20
>     ASoC: TWL4030: Use codec defaults for Headset initial configurati=
on
>=20
>     Disable the amplifiers for the headset outputs, and do not select
>     routings by default to the headset outputs.
>=20
>=20
> Does it work if you active the Headset path?
>=20
> amixer set -D hw:0 'Headset' 0dB
> amixer set -D hw:0 'HeadsetL Mixer AudioL2' on
> amixer set -D hw:0 'HeadsetR Mixer AudioR2' on

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
