From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: mysterious crashes on OMAP5 uevm
Date: Fri, 11 Sep 2015 18:34:34 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF740C24764@DLEE11.ent.ti.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
 <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
 <20150911140306.GB21098@n2100.arm.linux.org.uk>
 <EF62F09C0797D947AD4180A1043C0DF740C23E8D@DLEE11.ent.ti.com>
 <20150911174837.GC21098@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150911174837.GC21098@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, September 11, 2015 12:49 PM

> Frankly, Richard, you're getting on my nerves in this thread - you seem to
> know all about this problem, yet you never reported the problem upstream,
> so people are effectively having to waste time re-doing the work that you've
> already done.
>
> Nothing annoys me more than having people say "oh yes, I found that
> problem and worked on it" and nothing coming of it (no report, no patch, no
> nothing.)

Yes, when I put out the hint (to help speed resolution) I expected there might be some negative interpretation.

When I originally hit the issue, I did pass along information to folks who work in the area with expectation they would follow through.  Probably it got lost.

When I noticed this thread, it appeared like the CPSR.IT information didn't make it out, so I directly posted what I recalled.

> As you have "old notes" you've already investigated this issue, and
> presumably you came up with a patch.  Where is it?

I didn't generate a comprehensive one. I did a couple of hack versions but was unsure in some of the areas your analysis has cleared... for that issue I ended up advising a reversion of MULTI_V6 for that older kernel.

Regards,
Richard W.
