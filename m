From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: OMAP5: enable OTG role for DWC3 controller
Date: Fri, 28 Sep 2018 10:34:10 -0700
Message-ID: <20180928173410.GK5662@atomide.com>
References: <0c739437f2331913e6593d651fd782fde3181e0a.1538150039.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0c739437f2331913e6593d651fd782fde3181e0a.1538150039.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180928 08:58]:
> Since SMPS10 and OTG cable detection extcon are described here, and
> work to enable OTG power when an OTG cable is plugged in, we can
> define OTG mode in the controller (which is disabled by default in
> omap5.dtsi).
> 
> Tested on OMAP5EVM and Pyra.
> 
> Suggested-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks applying into omap-for-v4.20/dt.

Regards,

Tony
