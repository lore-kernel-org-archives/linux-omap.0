From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Fri, 20 Apr 2012 18:07:16 +0300
Message-ID: <1334934436.2149.49.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
 <1334926721.2149.40.camel@sokoban> <87vckupkxj.fsf@ti.com>
 <1334933002.2149.44.camel@sokoban>
 <CANQgH-aL42ka+veae0aPaebt=eA8iyF=ThVXGkOzFhNumKnhtw@mail.gmail.com>
Reply-To: t-kristo@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CANQgH-aL42ka+veae0aPaebt=eA8iyF=ThVXGkOzFhNumKnhtw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2012-04-20 at 20:21 +0530, Datta, Shubhrajyoti wrote:
> On Fri, Apr 20, 2012 at 8:13 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On Fri, 2012-04-20 at 06:55 -0700, Kevin Hilman wrote:
> >> Tero Kristo <t-kristo@ti.com> writes:
> >>
> >> [...]
> >>
> >> >> I tried your branch on gp/emu devices but could not reproduce this issue.
> >> >> My observation is that while resuming, omap_hsmmc.1 eMMC is
> >> >> trying to turn on phoenix vaux1 regulator via i2c which fails due
> >> >> to controller timeout.
> >> >> Note: eMMC is present only on sdp/blaze
> >> >
> >> > Did you try this with off-mode enabled and did you check the device
> >> > actually goes to off? (see pm_debug/count and verify core off count is
> >> > increasing.) And as said, I was only able to see this problem on a blaze
> >> > device, panda works fine. But yes, you are probably right and it is not
> >> > an MMC driver issue but I2C.
> >>
> >> Can you try the patch below?  It sounds like the same problem.
> >
> > Doesn't help with this one. I guess I2C loses context during device off
> > and it is not restored properly.
> >
> > -Tero
> Could you try the following patch
> 
> https://lkml.org/lkml/2012/3/30/345

That does the trick, after this it is working fine on blaze, and this
also fixes the timeout issues seen on panda board (meaning wake-up from
device off is much faster.)

-Tero
