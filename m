From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH 07/12] usb: sunxi: Uses the resource-managed extcon API
 when registering extcon notifier
Date: Mon, 5 Dec 2016 10:32:40 -0600
Message-ID: <20161205163240.GA5783@uda0271908>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-8-git-send-email-cw00.choi@samsung.com>
 <20161130084503.v5klzl6silp6323s@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161130084503.v5klzl6silp6323s@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org, Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 30, 2016 at 09:45:03AM +0100, Maxime Ripard wrote:
> On Wed, Nov 30, 2016 at 02:57:35PM +0900, Chanwoo Choi wrote:
> > This patch just uses the resource-managed extcon API when registering
> > the extcon notifier.
> > 
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

It would be ideal if the subject was "usb: musb: sunxi: ...".

Acked-by: Bin Liu <b-liu@ti.com>

Regards,
-Bin.
