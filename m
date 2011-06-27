From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Mon, 27 Jun 2011 10:15:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C30EE@dbde02.ent.ti.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
	<86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
	<DE79F8F5-7D8A-46B8-8C8C-C2A7515E9117@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <DE79F8F5-7D8A-46B8-8C8C-C2A7515E9117@dominion.thruhere.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org =

> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Sunday, June 26, 2011 1:41 AM
> To: linux-omap@vger.kernel.org List
> Cc: linux-arm-kernel; Paul Walmsley
> Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
> =

> =

> Op 25 jun 2011, om 20:51 heeft Premi, Sanjeev het volgende geschreven:
> =

> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org =

> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
> >> Sent: Saturday, June 25, 2011 1:47 PM
> >> To: linux-omap@vger.kernel.org List
> >> Cc: linux-arm-kernel; Paul Walmsley
> >> Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
> >> =

> >> =

> >> Op 24 jun 2011, om 18:23 heeft Sanjeev Premi het volgende =

> geschreven:
> >> =

> >>> The current selection of the GPTIMER on was result of
> >>> a hardware issue in early versions of the Beagleboards
> >>> (Ax and B1 thru B4). [1] [2]
> >>> =

> >>> Its been long since the hardware issue has been fixed.
> >>> This patch uses GPTIMER 1 for all newer board revisions
> >>> incl. Beagleboard XM.
> > =

> > [sp] I didn't include a reason - because the problem may not
> >     be reproducible on the public trees.
> > =

> >     During tests performed in internal development trees, the
> >     BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
> >     range. While there was no such inconsistency on OMAP3EVM.
> > =

> >     After few days of debug GPTIMER12 came to be only difference.
> >     Tracing GPTIMER12 in the spec proved quite a challenge; the
> >     as timer is not included in the TRM and corresponding interrupt
> >     is marked reserved. Paul (in cc:) obviously had access to
> >     documents that we don't.
> > =

> >     This patch is merely trying to bring parity in use of GPTIMER
> >     across OMAP3 boards (AND use documented IP) - taking note of
> >     many Beagleboards where current code is necessary.
> =

> I get a value of 1010 =B110 bogoMIPS consistently with .39 + =

> dvfs patches. Having said that, this patch does seem to be an =

> improvement, but has it actually been tested on real =

> beagleboard hardware with a recent kernel?

[sp] It was tested on BeagleXM RevB on top of linux-omap master - as
     on day of submitting th patch.

> Especially on the =

> boards affected by the capacitor issue on the external clock.--

[sp] The patch relies on the check for board revision to continue using
     GPTIMER12 on affected boards - which I am assuming to be right.

     I don't have access to any of these versions, trying to find some
     early users. Hope someone on the list with Ax/Bx version can share
     the result...

> To unsubscribe from this list: send the line "unsubscribe =

> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =
