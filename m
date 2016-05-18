From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.5-rc0 regression: GPRS breaks after very short while
Date: Wed, 18 May 2016 22:12:51 +0200
Message-ID: <20160518201251.GA22015@amd>
References: <20160518074924.GA20652@amd>
 <20160518141624.GA8025@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160518141624.GA8025@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> On Wed, May 18, 2016 at 09:49:24AM +0200, Pavel Machek wrote:
> > I was afraid another GSM chip desoldered itself in N900, but no, it
> > seems to be software this time.
> > 
> > In 4.4, GPRS is rock solid, can survive overnight ping.
> > 
> > In 4.5-rc0 and v4.6, modem fails when I use gprs for like a
> > minute. Phone is not usable.
> 
> I only send three modem related changes for v4.5:
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=hsi-for-4.5&id=525e1abc6b5a7d8bd9006de1da6e99722305ea2b
> HSI: omap_ssi: fix handling ida_simple_get result
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=hsi-for-4.5&id=6bf6ded3008a407ccab5ad72eb59ab71b97cc290
> HSI: omap_ssi_port: fix handling of_get_named_gpio result
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=hsi-for-4.5&id=403c5c0650816375527a6feecfb255d9b494dda3
> HSI: Remove struct hsi_client private fields from kernel-doc
> 
> The last one only changes a comment, so not relevant, the other
> two fix error handling during initialization and are most likely
> also not the problem. Can you try to bisect the problem?

It will not be fun, but I guess it is doable. But before I start it
would be good to know -- does it work for you?

Thanks and best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
