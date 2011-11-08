From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq
 resources
Date: Tue, 8 Nov 2011 12:17:35 +0000
Message-ID: <20111108121735.GD28350@mudshark.cambridge.arm.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-4-git-send-email-ming.lei@canonical.com>
 <20111024150814.GA4771@mudshark.cambridge.arm.com>
 <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
 <20111025083420.GA6184@mudshark.cambridge.arm.com>
 <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
 <CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
 <alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
 <CACVXFVPD90q0euQXXG+3ujyvzxCjAovFSSPKvqf6esU7vkD7Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46751 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab1KHMSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 07:18:07 -0500
Content-Disposition: inline
In-Reply-To: <CACVXFVPD90q0euQXXG+3ujyvzxCjAovFSSPKvqf6esU7vkD7Tg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "b-cousson@ti.com" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 08, 2011 at 09:25:52AM +0000, Ming Lei wrote:
> On Tue, Oct 25, 2011 at 7:00 PM, Paul Walmsley <paul@pwsan.com> wrote=
:
> >
> > Beno=EEt is the right person to review OMAP4 hwmod data.
>=20
> Beno=EEt, gentle ping, :-)

Note that I've taken the two perf patches into my perf/omap4 branch now=
:

http://git.kernel.org/?p=3Dlinux/kernel/git/will/linux.git;a=3Dshortlog=
;h=3Drefs/heads/perf/omap4

so it would be really good to see the platform parts getting picked up =
too.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
