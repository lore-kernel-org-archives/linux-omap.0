From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq
	resources
Date: Tue, 25 Oct 2011 09:34:20 +0100
Message-ID: <20111025083420.GA6184@mudshark.cambridge.arm.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-4-git-send-email-ming.lei@canonical.com>
	<20111024150814.GA4771@mudshark.cambridge.arm.com>
	<CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2011 at 02:09:22AM +0100, Ming Lei wrote:
> >> - =A0 =A0 for (i =3D 0; i < pmu_device->num_resources; ++i) {
> >> + =A0 =A0 for (i =3D 0; i < nr_cpu_ids; ++i) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D platform_get_irq(pmu_device, i);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq < 0)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> >
> > Hmm, I actually changed this code recently. Take a look:
> >
> > https://github.com/wdeacon/linux-wd/blob/perf/system-pmus/arch/arm/kern=
el/perf_event.c
> >
> > This should all be in for 3.2-rc1, so you can rebase then. If you still=
 have
> > hwmod issues, please solve them outside of perf_event.c
> =

> Looks your patch has solved the problem, so the patch is not needed
> any more.

Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP guys then I'm
happy to take the perf and PMU changes into my tree.

> I will try to rebase the patchset on your tree first.

Well that stuff should be in for -rc1, so you're probably better off
rebasing onto that when it lands. You could always use -next in the
meantime.

Cheers,

Will
