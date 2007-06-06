From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Qeury regarding EAC driver for omap 24xx
Date: Wed, 6 Jun 2007 18:03:49 +0530
Message-ID: <61445c750706060533o7453c2acl56f820688770acf3@mail.gmail.com>
References: <61445c750706060402q34388d3fm7bf2c097b34f6346@mail.gmail.com>
	<20070606150430.e4d55f5c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070606150430.e4d55f5c.jarkko.nikula@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks Jarkko.

On 6/6/07, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Wed, 6 Jun 2007 16:32:24 +0530
> "ext Pharaoh ." <pharaoh137@gmail.com> wrote:
>
> > I am referring the EAC driver for omap 24xx which is used by n800
> > board. The EAC 24xx driver
> > doesn't look complete since it has only hardware init sequences and
> > very basic ALSA related
> > functionalities i.e. register the sound card etc. Is omap 24xx eac
> > driver still in intermediate stage?Or
> > it is complete but not yet integrated in to omap git tree? In later
> > case, where can I find the complete
> > eac driver?
> >
> That's correct, it is mainly targeted for N800 where audio is coming
> from DSP side and driver is only charge of configuring digital audio
> interface and doing runtime clock and codec power management.
>
> I agree that native EAC ALSA PCM support would be nice but unfortunately
> we don't have any progress on that developing it.
>
> > Also, omap 24xx driver doesn't seem to follow the framework/structure
> > of other omap alsa
> > drivers in sound/arm/omap/ , any particular reason?  Please enlighten.
> >
> I think drivers in sound/arm/omap are somewhat "adrift". Codec drivers
> are tightly coupled into OMAP, they implement same global functions so
> that you cannot link them together, no clear separation between audio
> controller and codec, etc.
>
> Hopefully we see gradually those drivers ported into ASoC platform and
> codec drivers in order to get some change to get them into mainline.
>
>
> 	Jarkko
>
