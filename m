From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] MFD: twl4030-codec: APLL_INFREQ
	handling in the	MFD driver
Date: Tue, 3 Nov 2009 13:44:38 +0000
Message-ID: <20091103134437.GA22501@sirena.org.uk>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
	<20091102173035.GC8546@rakim.wolfsonmicro.main>
	<200911031537.50430.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200911031537.50430.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> on board. Another reason is that we have other part of the twl, which needs 
> resources from the codec part, but it is not loaded through the codec MFD, so 
> providing the needed information is kind of tricky with that setup.

I had thought that the sub-device was supposed to handle the arbitration
and could be used here.  But like we said, it's not going to make any
difference in the grand scheme of things.
