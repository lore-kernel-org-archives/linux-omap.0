From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Asoc with TWL4030 on overo
Date: Thu, 18 Mar 2010 16:40:02 +0200
Message-ID: <20100318164002.70c710a3.jhnikula@gmail.com>
References: <201003180823.55248.rok@kanardia.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:60120 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0CROiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 10:38:16 -0400
Received: by ewy8 with SMTP id 8so1223535ewy.28
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 07:38:14 -0700 (PDT)
In-Reply-To: <201003180823.55248.rok@kanardia.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rok =?UTF-8?B?TWFya292acSN?= <rok@kanardia.eu>
Cc: linux-omap@vger.kernel.org

Hi

On Thu, 18 Mar 2010 08:23:55 +0100
Rok Markovi=C4=8D <rok@kanardia.eu> wrote:

> I am trying to play sound on overo board. With latest kernel I cannot=
 get=20
> any sound, while with kernel 2.6.33-rc6-07400-ga05966f-dirty sound is=
=20
> played by ALSA correctly. I am using ALSA 1.0.22 with asound.conf lik=
e=20

Beagle plays fine on linux-omap head. One reason could be the patch
below as it requires that the user space must activate the headset
output path by proper mixer settings.

commit e47c796d58a21fc58b00dffb7265bb66de987773
Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Date:   Wed Feb 17 09:49:54 2010 +0200

    ASoC: TWL4030: Use codec defaults for Headset initial configuration
   =20
    Disable the amplifiers for the headset outputs, and do not select
    routings by default to the headset outputs.


Does it work if you active the Headset path?

amixer set -D hw:0 'Headset' 0dB
amixer set -D hw:0 'HeadsetL Mixer AudioL2' on
amixer set -D hw:0 'HeadsetR Mixer AudioR2' on


--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
