From: Tony Lindgren <tony@atomide.com>
Subject: Re: mysterious crashes on OMAP5 uevm
Date: Fri, 18 Sep 2015 10:48:18 -0700
Message-ID: <20150918174818.GF8020@atomide.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150908210708.GH4215@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Grazvydas,

* Tony Lindgren <tony@atomide.com> [150908 14:11]:
> * Grazvydas Ignotas <notasas@gmail.com> [150908 13:44]:
> > On Tue, Sep 8, 2015 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> OK nice to hear you found it. Yeah looks like some runtime
> capability check is needed.
>  
> > > Do you have some easy way to reproduce this issue?
> > 
> > Just moving a browser window around with mouse usually triggers it
> > within a minute.
> 
> OK good to know.

Just FYI, I too was now able to produce it here too moving around
icewweasel for about a minute. And can confirm Russell's patch
fixes the problem.

I'm using i3 tiling window manager here, and don't usually
ever have any floating windows which probably explains why I
did not run into this issue earlier with my lapdock experiments :)

Regards,

Tony
