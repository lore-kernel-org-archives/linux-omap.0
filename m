From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: DRA72x/DRA74x basic support
Date: Fri, 5 Sep 2014 18:03:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409051759530.9444@utopia.booyaka.com>
References: <alpine.DEB.2.02.1408280617360.21985@utopia.booyaka.com> <20140828170258.GH16006@atomide.com> <CAOesGMiudDK71Pzo+k9iiKJAcJzobc5z4+cpcomeJyM1KzbvgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57329 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaIESDI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2014 14:03:08 -0400
In-Reply-To: <CAOesGMiudDK71Pzo+k9iiKJAcJzobc5z4+cpcomeJyM1KzbvgQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Olof,

Sorry for the confusion, and thanks for the clarification.  

TI folks: no new platform support will be accepted through me for any 
future -rc series patchsets.


- Paul

On Sun, 31 Aug 2014, Olof Johansson wrote:

> This one clearly falls into the category of new platform support, not
> bugfixes. But it's pretty small so I'll pick it up this time.
> 
> 
> -Olof
> 
> On Thu, Aug 28, 2014 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Arnd & Olof,
> >
> > Can you please pick this one up for the -rc cycle so the TI guys
> > can boot test dra7 with mainline properly?
> >
> > Regards,
> >
> > Tony
> >
> > * Paul Walmsley <paul@pwsan.com> [140827 23:18]:
> >> Hi Tony,
> >>
> >> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
> >>
> >>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17-rc/omap-dra72x-d74x-support-a
> >>
> >> for you to fetch changes up to f7f7a29bf0cf25af23f37e5b5bf1368b85705286:
> >>
> >>   ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists (2014-08-27 19:38:23 -0600)
> >>
> >> ----------------------------------------------------------------
> >> Add basic subarchitecture support for the DRA72x and DRA74x.  These
> >> are OMAP2+ derivative SoCs.  This should be low-risk to existing OMAP
> >> platforms.
> >>
> >> Basic build, boot, and PM test logs are available here:
> >>
> >> http://www.pwsan.com/omap/testlogs/hwmod-a-early-v3.17-rc/20140827194314/
> >>
> >> ----------------------------------------------------------------
> >> Rajendra Nayak (2):
> >>       ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x() variants
> >>       ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists
> >>
> >>  arch/arm/mach-omap2/omap_hwmod.c          |  3 +++
> >>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 22 ++++++++++++++++++++--
> >>  arch/arm/mach-omap2/soc.h                 |  6 ++++++
> >>  3 files changed, 29 insertions(+), 2 deletions(-)
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
