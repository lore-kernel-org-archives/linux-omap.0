From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: remoteproc & OMAP3
Date: Tue, 17 Feb 2015 14:15:01 +0100
Message-ID: <20150217131501.GA28442@mir.local.igalia.com>
References: <54E33C96.9070403@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.mundo-r.com ([212.51.32.191]:40511 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752450AbbBQNZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2015 08:25:03 -0500
Content-Disposition: inline
In-Reply-To: <54E33C96.9070403@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sven Brandau <brandau@gmx.de>
Cc: linux-omap@vger.kernel.org

On 02/17/15 at 02:05pm, Sven Brandau wrote:
> Hi There,
> 
> is anyone working here on a implementation for remoteproc running on OMAP3
> SOCs?

No one as far as I heard. The last time I wondered about it, the agreement was
that it is not possible since you need to develop from scratch another
DSP-side firmware, and the available one only works for dspbridge/dsplink.

Regarding a new DSP-side firmware, I thought it was possible to put Linux,
since there's a port for the TI DSP, but somebody told me that the DSP
included in OMAP3 is not a port's target.

vmjl

> 
> Best regards,
> Sven
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
