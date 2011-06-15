From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: Re: Re: Re: [PATCH v4 11/18] input: Add initial support for
 TWL6040 vibrator
Date: Wed, 15 Jun 2011 10:23:01 +0200
Message-ID: <20110615082301.GN8141@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <4476185.bf2jyafmHt@barack>
 <20110614081836.GG8141@htj.dyndns.org>
 <100646074.zaKeYdXKr4@barack>
 <20110615081858.GM8141@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61072 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab1FOIXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 04:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20110615081858.GM8141@htj.dyndns.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>

On Wed, Jun 15, 2011 at 10:18:58AM +0200, Tejun Heo wrote:
> No human being can feel 120usec difference and I can't see how using
> HIGHPRI is justified here (which is what the code is doing
> _accidentally_ by using singlethread_workqueue).

Ooh, one more thing, and even if you insist on using HIGHPRI (please
don't), you don't need to create workqueue for each device.  You can
just create one for the whole driver in init and destroy it from exit.
What matters is the HIGHPRI attribute of the workqueue.  The number of
workqueues is completely irrelevant.

Thank you.

-- 
tejun
