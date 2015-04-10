From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3] ARM: AM43xx: hwmod: add VPFE hwmod entries
Date: Fri, 10 Apr 2015 22:51:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1504102248590.19540@utopia.booyaka.com>
References: <1422260488-380-1-git-send-email-prabhakar.csengg@gmail.com> <20150128193247.GH2570@ti.com> <alpine.DEB.2.02.1502102310010.3767@utopia.booyaka.com> <CA+V-a8vx=A8qQh4CtD7tjFwgBmkFPX7sUVuak8e4rH9N39gwfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+V-a8vx=A8qQh4CtD7tjFwgBmkFPX7sUVuak8e4rH9N39gwfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Benoit Parrot <bparrot@ti.com>, Tony Lindgren <tony@atomide.com>, LAK <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Prabhakar

On Fri, 10 Apr 2015, Lad, Prabhakar wrote:

> Hi Paul,
> 
> On Tue, Feb 10, 2015 at 11:10 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 28 Jan 2015, Benoit Parrot wrote:
> >
> >> Suspend/resume is functional with this patch.
> >>
> >> Tested-by: Benoit Parrot <bparrot@ti.com>
> >
> > Thanks folks, queued for v3.21.
> >
> >
> I see that this patch is not into linux-next yet.

thanks for the ping.  This slipped through the cracks here due to the 
kernel version number change from 3.21 to 4.1 :-(  Sorry about that; I 
will requeue for either 4.1-rc or 4.2.

Unfortunately I don't have an AM43xx board.  Is suspend/resume broken 
without this patch?  If so, then v4.1-rc seems like the appropriate 
target.


- Paul
