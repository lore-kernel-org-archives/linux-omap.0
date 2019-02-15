From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] more dts changes for omaps for v5.1
Date: Fri, 15 Feb 2019 18:23:03 +0100
Message-ID: <CAK8P3a03C15BJY4Z884-suceVZYO=kAzzLbjMUQukQV+xDvJWQ@mail.gmail.com>
References: <pull-1550167958-188990@atomide.com>
 <pull-1550167958-188990@atomide.com-2>
 <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
 <CAK8P3a0kZhJppsFzaTZL+PVCDP8BHwiquF6et3=i6MwA8YNpAg@mail.gmail.com>
 <20190215154742.GJ5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190215154742.GJ5720@atomide.com>
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

On Fri, Feb 15, 2019 at 4:47 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Arnd Bergmann <arnd@arndb.de> [190215 15:44]:
> > On Fri, Feb 15, 2019 at 4:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > During routine checks, I came across these gta04 warnings:
> >
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> > ../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
> > (graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
> > node unit address error, expected "0"
> >
> > Can you have a look and send a fix?
>
> Hmm sounds like that's because the branch is based on v5.0-rc1
> that is still missing already merged commit 5b90df44fd9b
> ("ARM: dts: omap3-gta04: Fix graph_port warning").

Ok, got it. Everything's fine then, sorry for my confusion.

     Arnd
