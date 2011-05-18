From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
Date: Wed, 18 May 2011 08:41:19 +0300
Message-ID: <201105180841.20224.peter.ujfalusi@ti.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com> <1305602079-3852-2-git-send-email-ricardo.neri@ti.com> <4DD2CDED.6090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45503 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1ERFlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 01:41:24 -0400
In-Reply-To: <4DD2CDED.6090605@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: "Neri, Ricardo" <ricardo.neri@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

On Tuesday 17 May 2011 22:35:09 Steve Calfee wrote:
> I think the generally accepted method of doing stuff like this is to
> have the ifdeffery in a header file where a inline code segment is
> defined if it applies to the processor being built. If the code does =
not
> apply to the model being built, a null #define is used, which does no=
t
> take any space.

We have for example omap2plus_defconfig, which include support for wide=
 range=20
of OMAP based devices, with different CPUs (OMAP2/3/4).
So we need to have runtime distinction of the CPU we are running (since=
 we run=20
the same kernel binary on OMAP2/3/4).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
