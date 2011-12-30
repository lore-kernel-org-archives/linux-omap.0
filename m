From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] It looks like snd-soc-rx51 only works as
 built-in, not as a module
Date: Fri, 30 Dec 2011 10:52:45 +0000
Message-ID: <20111230105244.GA21638@sirena.org.uk>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
 <20111210082741.GA32605@earth.universe>
 <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
 <20111229183712.GB32392@sirena.org.uk>
 <CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
 <20111229212707.GA9737@opensource.wolfsonmicro.com>
 <CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
 <20111229215407.GB9737@opensource.wolfsonmicro.com>
 <yw1x7h1ff26w.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48525 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1L3Kws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Dec 2011 05:52:48 -0500
Content-Disposition: inline
In-Reply-To: <yw1x7h1ff26w.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: M?ns Rullg?rd <mans@mansr.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Dec 29, 2011 at 10:22:31PM +0000, M?ns Rullg?rd wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > The reason the driver is not loaded automatically is that the OMAP
> > machine drivers have not been converted to platform devices.

> I posted patches doing the conversion a long time ago (September?).  It
> seems they got lost somewhere.

Most of them have been converted, but the rx51 wasn't.
