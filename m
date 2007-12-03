From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
Date: Mon, 3 Dec 2007 16:03:25 +0530
Message-ID: <5d5443650712030233i3d04ae8ar645d17abc5b04de@mail.gmail.com>
References: <20071129.190349.38313102.Hiroshi.DOYU@nokia.com>
	<20071129175535.GI11825@atomide.com>
	<20071130200221.GH7498@atomide.com>
	<20071203.105617.128163822.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071203.105617.128163822.Hiroshi.DOYU@nokia.com>
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
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Dec 3, 2007 2:26 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: "ext Tony Lindgren" <tony@atomide.com>
> Subject: Re: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
> Date: Fri, 30 Nov 2007 12:02:22 -0800
>
> > > > With OSK5912, I verified that the demo program("demo_console") worked
> > > > fine with your 3 patches. Probably something was broken just with
> > > > OMAP2. I am checking it bit more.
> > >
> > > OK, that's good to hear. Let's wait until you're happy before pushing
> > > this.
> >
> > I've pushed these patches, Hiroshi is looking into why omap2 dsp is
> > not currently working while omap1 is. It seems the problem is unrelated
> > to these patches.
>
> Actually dspgw itself is basically working with omap2 also. Probably
> there seems to be some missing update patches from N8x0 for other
> drivers, which are supposed to come soon.
>
> Anyway, thank you for you patches.
>
>         Hiroshi DOYU
>

Is there any plan to move dspgw code to use "dspfs" instead?

-- --Trilok Soni
