From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Tue, 11 Sep 2012 17:04:16 +0000
Message-ID: <201209111704.16708.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de> <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com> <504F6249.2090501@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <504F6249.2090501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kevin Hilman <khilman@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean Pihet <j-pihet@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, =?iso-8859-1?q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, J Keerthy <j-keerthy@t>
List-Id: linux-omap@vger.kernel.org

On Tuesday 11 September 2012, Vaibhav Hiremath wrote:
> On 9/11/2012 7:54 PM, Shilimkar, Santosh wrote:
> > On Tue, Sep 11, 2012 at 7:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Tuesday 11 September 2012, Shilimkar, Santosh wrote:
> >>> Just curious to know how you came with some of the above header names ?
> >>>
> >>> plat/mcbsp ---> dsp-mcbsp.h
> >>> There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
> >>> better name.
> >>
> >> This one was a mistake on my side, as Tony and  Peter already pointed out.
> >> How about asoc-mcbsp.h or asoc-omap-mcbsp.h?
> >>
> > After re-reading the cover-letter and your below response,
> > 'asoc-omap-mcbsp.h' seems to be fine.
> > 
> 
> Note that mcbsp is also applicable to Davinci family of devices.

asoc-ti-mcbsp.h then?

	Arnd
