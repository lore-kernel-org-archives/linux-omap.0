From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2] ti-soc-thermal: request temperature periodically if hw
 can't do that itself
Date: Tue, 24 Mar 2015 23:27:04 +0100
Message-ID: <20150324222704.GA19154@amd>
References: <20150103114632.GA21883@amd>
 <20150118202447.GA29014@amd>
 <20150324163032.GA13813@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150324163032.GA13813@developer.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-03-24 12:30:34, Eduardo Valentin wrote:
> On Sun, Jan 18, 2015 at 09:24:47PM +0100, Pavel Machek wrote:
> > 
> > When periodic mode is not enabled, it is neccessary to force reads.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> This is a malformed patch. here is patch output (or git am)
> patching file drivers/thermal/ti-soc-thermal/ti-bandgap.c
> patch: **** malformed patch at line 68: (english)
> http://www.livejournal.com/~pavelmachek

Sorry about that. You should have fixed [PATCHv3] in your inbox now.

> I would really recommend you to use git to send your patches to avoid
> such problems. Can you please resend this patch in its proper
> format?

Done.

I verified that the other 2 patches are ok, by applying them in
following order:

Subject: [PATCHv3] ti-soc-thermal: request temperature periodically if
hw can't do that itself

Date: Sun, 18 Jan 2015 21:20:51 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] ti-soc-thermal: implement eocz bit to make driver
useful on omap3

Date: Sun, 18 Jan 2015 21:17:10 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] cleanup ti-soc-thermal

Best regards and thanks for patience,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
