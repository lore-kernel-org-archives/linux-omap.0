From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Wed, 14 Jan 2009 10:27:29 +0200
Message-ID: <1231921649.13843.171.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17694 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbZANIaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 03:30:52 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0E8UOLY023728
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 10:30:49 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0E8TgNg029235
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 10:29:42 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> >> - According to Jarkko Nikula, ASoC does not currently work because
> >>  of some recent clock changes.

I would like to note, that currently there's no counterpart for this
commit:

3456ef483b5322ba4a7647f024e2c5b7846cd7e3

ARM: OMAP3: Enable writing to XCCR and RCCR McBSP registers for OMAP
2430/34xx


You need to have the counterpart (in /sound/soc/omap/omap-mcbsp.c) for
that patch, othwerwise there's no chance to hear any DMA transferred
audio.

- Eero

