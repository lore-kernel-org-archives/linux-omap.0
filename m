From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: add bq2415x charger driver
Date: Tue, 6 Dec 2011 11:46:03 +0000
Message-ID: <20111206114602.GA17731@opensource.wolfsonmicro.com>
References: <1323124541-7590-1-git-send-email-felipe.contreras@nokia.com>
 <20111206113131.GE17194@sirena.org.uk>
 <CAMP44s0VSdVo6EhvgVUcwryK39iss0mvDbxKjaeH_S+Vp4DwBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMP44s0VSdVo6EhvgVUcwryK39iss0mvDbxKjaeH_S+Vp4DwBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Pali Roh??r <pali.rohar@gmail.com>, Aliaksei Katovich <aliaksei.katovich@nokia.com>, Vladimir Zapolskiy <vz@mleia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 06, 2011 at 01:43:06PM +0200, Felipe Contreras wrote:

> Yes, for this particular case the regulator API might be useful, but I
> don't see how external code will use this. Will they have to search
> for the name of this regulator, and then try to change the
> current_limit?

No, they'd get hooked in via the regulator interface as consumers.  Like
I say it depends on how autonomous the chip is, if it needs a lot of TLC
then it's probably not a regulator thing.  If all you do the chip is
turn in on and off and set limits then the upper layer should really be
able to be independant of the chip.

> > its thing and run autonomously starting, stopping and fast charging by
> > itself then a power supply driver seems like a good fit - just provide
> > the upper limits as platform data or something and watch it go.

> It would have to change its behavior depending on external events,
> like charger plugged/unplugged, different types of chargers, and so
> on. I'm thinking the rx51 board code could join some hooks from
> isp1704 (which detects the events) into this driver.

That stuff definitely sounds like power supply material - there's been
several other people discussing extending the framework to make it
easier for different power supply chain elements to coordinate with each
other.  
