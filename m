From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 0/2] Sil9022 DPI to HDMI Encoder
Date: Tue, 18 Mar 2014 10:56:40 +0000
Message-ID: <20140318105640.GE8043@e106331-lin.cambridge.arm.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39430 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754867AbaCRK4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 06:56:49 -0400
Content-Disposition: inline
In-Reply-To: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

On Tue, Mar 18, 2014 at 10:07:55AM +0000, Sathya Prakash M R wrote:
> This patch series adds the Silicon Image Sil9022 driver.
> 
> Sil9022 is HDMI Transmitter compliant to HDMI 1.2a and DVI 1.0.
> It supports 1080p and UXGA. It has single slave I2C from Host,
> passing through to master I2C interface for DDC Connection.
> It provides Transmitter Programming Interface (TPI) for simplified API programming.
> Product brief:
> http://www.semiconductorstore.com/pdf/newsite/siliconimage/SiI9022a_pb.pdf
> 
> Current driver is tested on AM43x SOC.
> 
> This series is on top of series posted to add DSS support on AM43x [2]
> [2] https://patchwork.kernel.org/patch/3822691/
> 
> This is initial driver supporting limited features.
> 
> TODO ->
> Audio Support
> Detailed Hot Plug event handling and also routing the hot plug event to host processor
> 
> These features will be added in future.
> 
> Sathya Prakash M R (2):
>   OMAPDSS: Add Sil9022 DPI-HDMI Encoder Driver
>   ARM: DTS: AM43x: Add sii9022 dt information
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts                |   58 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts               |   59 +-
>  drivers/video/omap2/displays-new/Kconfig           |    8 +
>  drivers/video/omap2/displays-new/Makefile          |    1 +
>  drivers/video/omap2/displays-new/encoder-sil9022.c |  748 ++++++++++++++++++++
>  drivers/video/omap2/displays-new/encoder-sil9022.h |  105 +++
>  6 files changed, 973 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.c
>  create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.h

Is there already a binding document?

If not, please add one.

Cheers,
Mark.
