From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 0/2] ARM: update cpuinfo to print CPU model name
Date: Tue, 29 Jan 2013 17:38:42 -0600
Message-ID: <20130129233842.GA8024@kahuna>
References: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
 <20130129160243.GA3389@kahuna>
 <CAB=otbSV6CH4WOrr577bHXFcjEVRGjZxatgy4CJ3cr0M0h4vfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbSV6CH4WOrr577bHXFcjEVRGjZxatgy4CJ3cr0M0h4vfw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01:08-20130130, Ruslan Bilovol wrote:
> Hi,
> 
> On Tue, Jan 29, 2013 at 6:02 PM, Nishanth Menon <nm@ti.com> wrote:
> >
> > On 17:54-20130129, Ruslan Bilovol wrote:
> > > Hi,
> > >
> > > The following patches update cpuinfo to print CPU
> > > model name for ARM. First patch exactly makes needed
> > > changes for ARM architecture.
> > > Second patch adds this ability to OMAP4 SoCs.
> > >
> > > This adds a common approach to show SoC name.
> > >
> > > Looks like there were few attempts to do similar
> > > changes to cpuinfo without any luck.
> > >
> > > So - comments are welcome
> > >
> > > Ruslan Bilovol (2):
> > >   ARM: kernel: update cpuinfo to print CPU model name
> > >   ARM: OMAP4: setup CPU model name during ID initialisation
> >
> > We had an discussion on similar lines but a generic suggestion:
> > https://patchwork.kernel.org/patch/98720/
> > SoCinfo framework which was supposed to introduce this
> >
> > Would'nt that be a better approach to take than an OMAP only solution?
> 
> My goal is only to say what is the SoC model name in the /proc/cpuinfo
> (And it is not an OMAP-only solution - it is common. Support for OMAP
> is added in second patch)
> This is the only type of information that we can apply for any SoC.
> My point is - any SoC-specific information should go through some other
> way - like SoCinfo framework mentioned by you.
> And additional point - in cpuinfo we already have CPU name and Machine name.
> The SoC name (that is something between these two things) looks also relevant
Looking at the sample output in patch #1/2
OMAP4470 ES1.0 HS

OMAP4470 is SoC name
ES1.0 is SoC revision
HS is SoC type

We even have SoC features (e.g. at boot NEON etc..)

Is the intent to put all this inside /proc/cpuinfo?? I bet every SoC has
it's own interesting data it'd like to have (like some of the info
populated by DT even). I am hardpressed to think this fits inside
/proc/cpuinfo. I might even suspect that the list of interesting
information might even vary per SoC.

having machine name is something ARM specific? dumping it on my linux
machines (x86[1] and sparc[2]) dont seem to show that.

but in the interest of not breaking existing interfaces, new interfaces
should potentially belong elsewhere.. my 2 cents.

[1] http://pastebin.com/CF8HPDAC (Xubuntu 12.04 3.2.0-36)
[2] http://pastebin.com/qNwWHwiu (Debian 3.2.35-2)
-- 
Regards,
Nishanth Menon
