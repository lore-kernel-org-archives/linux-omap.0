From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Wed, 22 Apr 2009 13:05:40 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0106373FD4@dlee02.ent.ti.com>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52931 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbZDVSFt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 14:05:49 -0400
In-Reply-To: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of twebb
> Sent: Wednesday, April 22, 2009 12:58 PM

> Problem 2:
> Test tone is being presented by the user application, providing a 1Khz
> tone sampled at 44.1Khz. The data are S16_LE, right channel only. Left
> channel is quiet. The data seems to slip back and forth from left to
> right channel. This is reproducable and verified with a scope trace.
I recollect this issue from years back of OSS driver -> i2s is configured as dual phase - mcbsp sends data on both edges, and if the data write happen on the wrong edge for the wrong phase, we might get mix up.. if I recollect right, configuration for mcbsp was done as a single phase with the right edge as a trigger for transfer, the transfer size was set as 32 bytes (both channels).. this essentially guarentees that mcbsp will never mix up channels.

Regards,
Nishanth Menon

