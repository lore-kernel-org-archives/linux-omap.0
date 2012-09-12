From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Wed, 12 Sep 2012 03:53:45 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB18FD@DBDE01.ent.ti.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com>
 <504F6249.2090501@ti.com> <201209111704.16708.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201209111704.16708.arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, "Ramirez Luna,
 Omar" <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "Valkeinen,
 Tomi" <tomi.valkeinen@ti.com>, "Girdwood, Liam" <lrg@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "Cousson,
 Benoit" <b-cousson@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pihet-XID,
 Jean" <j-pihet@ti.com>, Kyungmin
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 22:34:16, Arnd Bergmann wrote:
> On Tuesday 11 September 2012, Vaibhav Hiremath wrote:
> > On 9/11/2012 7:54 PM, Shilimkar, Santosh wrote:
> > > On Tue, Sep 11, 2012 at 7:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > >> On Tuesday 11 September 2012, Shilimkar, Santosh wrote:
> > >>> Just curious to know how you came with some of the above header names ?
> > >>>
> > >>> plat/mcbsp ---> dsp-mcbsp.h
> > >>> There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
> > >>> better name.
> > >>
> > >> This one was a mistake on my side, as Tony and  Peter already pointed out.
> > >> How about asoc-mcbsp.h or asoc-omap-mcbsp.h?
> > >>
> > > After re-reading the cover-letter and your below response,
> > > 'asoc-omap-mcbsp.h' seems to be fine.
> > > 
> > 
> > Note that mcbsp is also applicable to Davinci family of devices.
> 
> asoc-ti-mcbsp.h then?
> 

Looks ok to me.

Thanks,
Vaibhav

> 	Arnd
> 
