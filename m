From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: update default gamma
Date: Tue, 14 Feb 2012 15:14:50 +0200
Message-ID: <CANOLnONLHgRzZ-rez4p9Ou6qCtoWVhZWPXNEgsQarBRVFstTaw@mail.gmail.com>
References: <1328573630-7348-1-git-send-email-notasas@gmail.com>
	<1328573630-7348-2-git-send-email-notasas@gmail.com>
	<1329222910.1845.90.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47489 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab2BNNOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 08:14:50 -0500
In-Reply-To: <1329222910.1845.90.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Feb 14, 2012 at 2:35 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi,
>
> On Tue, 2012-02-07 at 02:13 +0200, Grazvydas Ignotas wrote:
>> Over time better gamma has been determined and tuned with some
>> equipment so update the defaults. From subjective point of view
>> dark shades should be better visible.
>
> Is there even need for default gamma? I'd guess the panel has a defau=
lt
> gamma in its firmware, so it should work fine without setting it. And
> there's sysfs interface to set the gamma from userspace.
>
> And, as you said, it's subjective, i.e. there's no right value for it=
,
> so I'm a bit inclined to say that the driver shouldn't even set a
> default gamma, and just leave it to userspace.

Well for pandora, we encourage people to run custom Linux distros on
the device, people reported running Debian, Arch and Slackware on the
device, so we don't have control over everyone's userspace. To reduce
the need for everyone to hack userspace of their distro of choice, it
would be great to have nice display just from the kernel,
out-of-the-box (this gamma has been tuned with some TV studio
equipment so is not totally subjective). Still if you don't want it,
we can keep carrying that in pandora's kernel tree too.


--=20
Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
