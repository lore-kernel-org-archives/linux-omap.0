From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Fri, 09 Oct 2009 08:09:27 +0300
Message-ID: <1255064967.30157.178.camel@eenurkka-desktop>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
	<20091008131702.GC29176@rakim.wolfsonmicro.main>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2009-10-08 at 15:17 +0200, ext Mark Brown wrote:
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

Hmm. What would be the way to transfer 128 x s16 words; is there an ALSA
control for something like that already ? IIRC correctly, the max
bytesize per control is (or used to be) something like 256 bytes or so.
So that gets right at it. (that's the sidetone 128 tap FIR in question)

- Eero


