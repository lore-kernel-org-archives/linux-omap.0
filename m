From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [alsa-devel] [PATCH 11/20] OMAP: McBSP: Add link DMA mode
 selection
Date: Thu, 6 Aug 2009 20:15:40 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <20090805103900.5ad89efe.jhnikula@gmail.com>,<200908051158.57440.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51608 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZHFSP7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 14:15:59 -0400
In-Reply-To: <200908051158.57440.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@nokia.com, alsa-devel@alsa-project.org
Cc: jhnikula@gmail.com, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org


>>
>> I would say the default mode for the omap34xx should be also element=
 as
>> it keeps the omap_pcm_pointer behavior the same than currently and
>> avoids possible regression.
>=20
> Yes, the default mode should be the element mode in my opinion as wel=
l.
>=20
> --
> P=E9ter


Well, the element mode is fine for !McBSP2. One doesn't really loose th=
e
buffer pointer accuracy, because you can get the last DMA irq timestamp
with SNDRV_PCM_IOCTL_TTSTAMP (and compare that to current time).
The accuracy is not far off from the element mode? (If you read the DMA
portion of TRM, I think there were some issues as well)

Don't want to be piccy, but McBSP2 with element mode is more or less li=
ke
a "joke"? As there's a large HW bugger, why not take advantage of it..w=
hy=20
"bypass"  it as default?

=46or !McBSP2, it doesn't even pay to have the threshold mode at all, b=
ecause
the effect on PM is actually adverse - too frequent wakeups will cause =
more
adverse net effect on PM (IIRC) @ VBAT.

- Eero --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
