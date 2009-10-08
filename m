From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Thu, 8 Oct 2009 16:23:33 +0300
Message-ID: <20091008132333.GC9558@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
	<20091008131702.GC29176@rakim.wolfsonmicro.main>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091008131702.GC29176@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 08, 2009 at 03:17:02PM +0200, Mark Brown wrote:
> On Thu, Oct 08, 2009 at 02:58:52PM +0300, Eduardo Valentin wrote:
> 
> > +static const struct attribute *sidetone_attrs[] = {
> > +	&dev_attr_st_enable.attr,
> > +	&dev_attr_st_taps.attr,
> > +	&dev_attr_st_ch0gain.attr,
> > +	&dev_attr_st_ch1gain.attr,
> > +	NULL,
> > +};
> 
> This stuff, particularly the enable, probably wants to be pushed out via
> an ALSA API rather than via random sysfs stuff.  It'd be better to
> publish a control API here and then use that from within ALSA.


I see. The thing is this mcbsp driver is kinda of odd driver.
It is currently a platform driver. And it is supposed to be not
restricted to audio things (even though it is currently used only
by audio). It does not export any alsa interface currently.


So, maybe we should rip off this sysfs things, export
symbols inside kernel and then export to user land somewhere else
from alsa code?


-- 
Eduardo Valentin
