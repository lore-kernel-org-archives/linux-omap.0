From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] more dts changes for omaps for v5.1
Date: Fri, 15 Feb 2019 16:43:37 +0100
Message-ID: <CAK8P3a0kZhJppsFzaTZL+PVCDP8BHwiquF6et3=i6MwA8YNpAg@mail.gmail.com>
References: <pull-1550167958-188990@atomide.com>
 <pull-1550167958-188990@atomide.com-2>
 <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 15, 2019 at 4:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 14, 2019 at 7:13 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > From: "Tony Lindgren" <tony@atomide.com>
> >
> > The following changes since commit b4c30df0eb354d8e081132b7b7449f6d17619614:
> >
> >   ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot (2019-01-24 08:23:43 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-pt2-signed
> >
> > for you to fetch changes up to 947b7802597106dcbef2ddca23d386f9339ba334:
> >
> >   ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)
> >
> > ----------------------------------------------------------------
> > More dts changes for omaps
> >
> > We add support for Bosch Guardian am335x device, and configure more
> > devices like GNSS and LCD backlight for omap3-gta04. And we replace
> > the wlcore binding documentation URL with a local file that we have.
>
> Pulled into arm/dt, thanks!
>

During routine checks, I came across these gta04 warnings:

../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"
../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"
../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"
../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"

Can you have a look and send a fix?

      Arnd
