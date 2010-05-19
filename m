From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Thu, 20 May 2010 00:00:58 +0900
Message-ID: <20100519150057.GA16082@linux-sh.org>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange> <Pine.LNX.4.64.1005071102440.4777@axis700.grange> <1274255350.2307.159.camel@tubuntu.research.nokia.com> <Pine.LNX.4.64.1005190955500.3099@axis700.grange> <1274257308.2307.168.camel@tubuntu.research.nokia.com> <20100519142732.GG30960@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:45660 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab0ESPB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 11:01:56 -0400
Content-Disposition: inline
In-Reply-To: <20100519142732.GG30960@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ville Syrj?l? <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, May 19, 2010 at 05:27:32PM +0300, Ville Syrj?l? wrote:
> On Wed, May 19, 2010 at 10:21:48AM +0200, Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> > I think a simple solution would be to just use defines, and have
> > functions that take the command as u8. That's what the OMAP DSI driver
> > does. If you have better ideas, please share =).
> 
> I find enums easier on the eye than defines. Less irrelevant junk on
> each line. There's no reason you can't pass enum values as u8. But in
> that case giving the enum a name doesn't really make sense.
> 
enums are cleaner for these cases, but you also have the case where the
enum type itself is variable size depending on the ABI being used. If
the type in question isn't being packed in to a user-visible data
structure then this will never matter, but it does help to be a bit
careful here regardless. Many people were bitten by this in the ARM
OABI -> EABI conversion, while other architectures generally managed to
get it right from the onset.
