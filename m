From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v7 0/5] OMAP: McBSP: Use register cache
Date: Wed, 16 Dec 2009 10:02:53 +0200
Message-ID: <200912161002.53534.peter.ujfalusi@nokia.com>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42872 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759129AbZLPIE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 03:04:56 -0500
In-Reply-To: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Janusz,

I'll try to go through the series.

On Wednesday 09 December 2009 22:24:13 ext Janusz Krzysztofik wrote:

> This could help for developing the McBSP context save/restore feature=
s, as
> well as solve the problem of possible register corruption, experience=
d on
> OMAP1510 based Amstrad Delta board at least.

=46or the context save/restore feature:
On OMAP3 this is not that straight forward IMHO.
OMAP3 has FIFO on the McBSP ports (1024+256, or 128 word long).
This buffer will be invalidated in case of OFF mode (or when context=20
save/restore is needed).
So if we ever face with this situation, we need to make sure that the M=
cBSP FIFO=20
is empty prior to context save, so when we are restoring we are not goi=
ng to=20
loose any data.
Note also, that the McBSP FIFO can not be bypassed on OMAP3, which mean=
s that=20
the FIFO is most of the time is kind of full.
Well, full in element mode, and mostly full in threshold mode.

In other words: on OMAP3 the context save/restore is not that simple as=
 it is on=20
OMAP1/2. We need to make sure that the FIFO is empty at the right momen=
t, which=20
can not be done with the current code, and to be honest, I can not see =
how it=20
can be done, unless we branch out the OMAP3 related McBSP/DMA code, and=
 leave=20
the current implementation to support only OMAP1/2 class devices.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
