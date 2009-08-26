From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Audio capture not working with AIC23/McBSP1 on
	OMAP3517
Date: Wed, 26 Aug 2009 14:03:56 +0100
Message-ID: <20090826130356.GB29299@sirena.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38092 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919AbZHZNDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 09:03:55 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

On Wed, Aug 26, 2009 at 06:30:52PM +0530, Aggarwal, Anuj wrote:

> I am trying to capture audio through LineIn on my OMAP3517 EVM, using 
> AIC23 codec and McBSP1, and getting the following error:

> arecord: pcm_read:1529: read error: Input/output error

That suggests that DMA isn't happening - might be worth checking to see
that clocks are being generated properly.

> Playback is working fine using the same combination. 

> I have tried using another instance of AIC23 codec which uses McBSP2 
> and both playback & capture works fine there.

> Has anyone faced this issue before? Any suggestions?

Which kernel are you using?  There are rather a lot of McBSP changes
queued up for 2.6.32.  If this ever worked in the past a git bisect
might be interesting.
