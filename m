From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage of regulator
	framework to control avdd_dac
Date: Fri, 9 Oct 2009 11:19:45 +0100
Message-ID: <20091009101945.GA23679@opensource.wolfsonmicro.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com> <1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com> <1255004227.30157.159.camel@eenurkka-desktop> <1FFEF31EBAA4F64B80D33027D42977600E85F0CC91@NOK-EUMSG-02.mgdnok.nokia.com> <1C729A43-F9F2-4FF6-A07E-5450E595982B@opensource.wolfsonmicro.com> <1255062483.30157.171.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51265 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760614AbZJIKUZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 06:20:25 -0400
Content-Disposition: inline
In-Reply-To: <1255062483.30157.171.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "<tony@atomide.com>" <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "<jhnikula@gmail.com>" <jhnikula@gmail.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<alsa-devel@vger.kernel.org>" <alsa-devel@vger.kernel.org>

On Fri, Oct 09, 2009 at 07:28:03AM +0300, Eero Nurkkala wrote:
> On Thu, 2009-10-08 at 18:01 +0200, ext Mark Brown wrote:

> > I'd expect the usage would be that after the audio subsystem has been  
> > idle for some configurable period of time the core would bring the  
> > audio subsystem down to bias off, at which point supplies could also  
> > be switched off.

> Right. That would also sound like the RST line also needs also be
> asserted, and then rewriting all register contents upon wakeup? And also
> redirecting all i2c traffic to the cache instead of any real i2c writes
> (meanwhile the device is shut down)? Like in tpa6130?

Yes.  I'd expect that if this is being implemented there'll be some
degree of assistance from the core for some of this.
