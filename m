From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/7] OMAP4: hwmod data fixes and update
Date: Tue, 21 Dec 2010 16:03:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012211556480.1446@utopia.booyaka.com>
References: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1400292154-1292972596=:1446"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41819 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0LUXDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 18:03:17 -0500
In-Reply-To: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1400292154-1292972596=:1446
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt

On Wed, 15 Dec 2010, Benoit Cousson wrote:

> Here is a small set of OMAP4 hwmod data updates.
>=20
> Re-order properly the data that were a little bit shuffled during
> the previous merge window.
> Add the new reset flags introduced in 2.6.37 and that were not
> used in the hwmod data. The OMAP2 and OMAP3 fixes should come soon...
> ...maybe not that soon :-)
> Fix some missing field in the GPIO OMAP4 hwmod data that I missed
> during the review.
> IVA and DSP are added just to allow the processors device creation
> at boot time and avoid the warnings.
>=20
> Thanks to Charu for testing the GPIO / WD_TIMER changes.
> Thanks to Govindraj for testing the UART changes.=20
>=20
> The series is based on your clk_a_2.6.38 branch from your integration tre=
e
> (git://git.pwsan.com/linux-integration) and is available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_data
>=20
> Please note that there is a slight dependency with the following patch
> due to the name change of the iva fclk:
> OMAP4: clock data: Add missing DPLL x2 clock node
> https://patchwork.kernel.org/patch/396612/
>=20
> Tested on sdp4430 + ES2.0/ES2.1.
>=20
> Regards,
> Benoit
>=20
>=20
> Changes since v1:
>     http://www.spinics.net/lists/arm-kernel/msg107082.html:
>     - Include the changelog fixes from Paul
>     - Fix the order of the dsp hwmod data
>     - Fix OMAP2430 i2c dev_attr warning (minor fix, but not tested)
>     - Include Kevin's patch to fix wakeup in hwmod core
>    =20
>=20
> Benoit Cousson (6):
>   OMAP4: hwmod data: Fix hwmod entries order
>   OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
>   OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
>   OMAP4: hwmod data: Add IVA and DSP
>   OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
>   OMAP2430: hwmod data: Use common dev_attr for i2c1 and i2c2
>=20
> Kevin Hilman (1):
>   OMAP2+: omap_hwmod: fix wakeup enable/disable for consistency

Thanks, I've updated the hwmod_b_2.6.38 branch with these changes.

The 'integration-2.6.38-20101221-002' tag on=20
git://git.pwsan.com/linux-integration contains the updated patches, as=20
well as previous dependencies, based on Tony's current omap-for-linus=20
branch.


- Paul
--155748971-1400292154-1292972596=:1446--
