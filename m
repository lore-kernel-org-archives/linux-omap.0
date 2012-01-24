From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Tue, 24 Jan 2012 01:36:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201240134421.29673@utopia.booyaka.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com> <4EEB5913.3090901@ti.com> <alpine.DEB.2.00.1112191451140.12660@utopia.booyaka.com>
 <4F1D4A03.3050700@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1807529546-1327394163=:29673"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49731 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab2AXIgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 03:36:03 -0500
In-Reply-To: <4F1D4A03.3050700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1807529546-1327394163=:29673
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter

On Mon, 23 Jan 2012, Peter Ujfalusi wrote:

> On 12/19/2011 11:51 PM, Paul Walmsley wrote:
> > On Fri, 16 Dec 2011, Cousson, Benoit wrote:
> >=20
> >> On 12/16/2011 7:28 AM, Paul Walmsley wrote:
> >>> On Mon, 28 Nov 2011, Peter Ujfalusi wrote:
> >>>
> >>>> To be able to get the memory resources by name from
> >>>> the DMIC driver (for MPU and for DMA).
> >>>
> >>> Any comments on this one?  Looks like we'd need to add these names as
> >>> hints in the script.
> >>
> >> Maybe not, in theory we should be able to detect the dual mapping and =
add the
> >> proper name. I did that for some other IP in the ABE domain, so it sho=
uld be
> >> doable for that one too.
> >>
> >>>> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> >>
> >> Acked-by: Benoit Cousson <b-cousson@ti.com>
> >=20
> > Cool.  Queued for when Tony wants to pull it.
>=20
> This patch seams to be missing from 3.3-rc1. The rest of the series is
> there, but because of the missing patch audio does not probe on
> 4430SDP/Blaze.
> Can you queue this as a fix for Linus?

Doh, not sure what happened here.  A brief triage question.  Did audio=20
probe correctly on 4430SDP/Blaze on 3.2?


- Paul
--155748971-1807529546-1327394163=:29673--
