From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] ASoC : underrun messages
Date: Wed, 28 Jan 2009 14:40:57 +0000
Message-ID: <20090128144055.GB15551@sirena.org.uk>
References: <ef0d8a250901280539v7f0b4a74nfb698796e72fb247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3105 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZA1OlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 09:41:03 -0500
Content-Disposition: inline
In-Reply-To: <ef0d8a250901280539v7f0b4a74nfb698796e72fb247@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 07:09:10PM +0530, Naveen Krishna Ch wrote:

> I saw the same isue with 2.6.26 some one suggested me to find
> if there is any bug in the asoc layer.
> Now i am using 2.6.28 kernel from kernel.org but still got the same

> Can any one suggest me a way to find a fix for this..

As discussed the last time you reported this you should check to ensure
that aplay is able to read the data it is trying to play fast enough to
supply it to the audio drivers.  Storing the audio files in a ramdisk
should do the trick.
