From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: TSC2046 touchscreen support for 2430
Date: Tue, 8 May 2007 10:54:58 +0530
Message-ID: <5d5443650705072224v10448307n89c86413293a6be@mail.gmail.com>
References: <20070504214028.649198901@mvista.com>
	<20070504214039.632228613@mvista.com>
	<3a5b1be00705050128m7de63c62hc5f1c34eb1f91613@mail.gmail.com>
	<5d5443650705070202w50514779o9066e482f67d2019@mail.gmail.com>
	<5d5443650705070323r7ffa5e3bi9bc4e7b42574a8bc@mail.gmail.com>
	<1178557371.32585.22.camel@paris.hilman.org>
	<20070507172440.GA31968@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070507172440.GA31968@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/7/07, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@mvista.com> [070507 10:03]:
> > On Mon, 2007-05-07 at 15:53 +0530, Trilok Soni wrote:
> > > On 5/7/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> > > > Tony,
> > > >
> > > > On 5/5/07, Komal Shah <komal.shah802003@gmail.com> wrote:
> > > > > Kevin,
> > > > >
> > > > > On 5/5/07, Kevin Hilman <khilman@mvista.com> wrote:
> > > > > > This is a rework of the tsc2046 driver from TI's tree, based
> > > > > > on the tsc2301 driver and using the new SPI framework.
> > > > > >
> > > > > > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> > > > >
> > > > > Very small changes required in order to confirm CodingStyle.
> > > > >
> > > >
> > > > I have attached two patches implementing changes as suggested by
> > > > Komal. They are compile tested only.
> > > >
> > >
> > > Attached 3rd patch fixes suspend/resume functions, as TSC2046 is TS
> > > only device not like TSC2301, so we don't need to make non-static
> > > functions like TSC2301_TS which gets called from it's core driver on
> > > suspend/resume.
> > >
> > > This patch is also compile-tested only. Kevin please test it.
> >
> > Trilok,
> >
> > Thanks for the cleanups and PM support.  I have tested all 3 patches and
> > the driver is still working well.
>
> Cool, will push today.
>

Have you applied first two cleanup patches? I can only see PM patch
(3rd patch) on master branch.

-- 
--Trilok Soni
