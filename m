From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Audio on OMAP3
Date: Sun, 09 Aug 2009 14:34:18 -0600
Message-ID: <4A7F32CA.8000108@mlbassoc.com>
References: <4A7F068D.6090407@mlbassoc.com> <20090809190452.GC4390@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:4708 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZHIUeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Aug 2009 16:34:20 -0400
In-Reply-To: <20090809190452.GC4390@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org

Mark Brown wrote:
> On Sun, Aug 09, 2009 at 11:25:33AM -0600, Gary Thomas wrote:
> 
>> How is audio supported on OMAP3?  In particular via the
>> TWL4030/TPS659x0 chip?  Is anyone working on this?
> 
> This is supported in the ASoC subsystem - see sound/soc/omap for the
> OMAP specific stuff and sound/soc/codecs/twl4030.c for the TWL4030
> specifics.

Thanks.  How is this normally configured - ALSA or OSS?
What tools have been used (simple busybox system, not Android)?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
