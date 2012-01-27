From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 13:28:26 +0000
Message-ID: <20120127132826.GD2347@mudshark.cambridge.arm.com>
References: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
	<CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
	<CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Mans,

On Fri, Jan 27, 2012 at 12:56:35PM +0000, M=E5ns Rullg=E5rd wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > Did this lead anywhere in the end? It seems as though Ming Lei has a wo=
rking
> > setup but Stephane is unable to replicate it, despite applying the nece=
ssary
> > patches and trying an updated bootloader.
> =

> With the patches listed above plus the one in [1], I get PMU interrupts.
> However, unless I restrict the profiled process to one CPU
> (taskset 1 perf record ...), I get a panic in armpmu_event_update() with
> the 'event' argument being null when called from armv7pmu_handle_irq().
> =

> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696

Great, thanks for trying this out. Which version of the kernel were you
using? I fixed a bunch of NULL pointer derefs. during the 3.2 window, but if
you were using an -rc kernel you have have hit one of them.

Will

---------------------------------------------------------------------------=
---
Try before you buy =3D See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
