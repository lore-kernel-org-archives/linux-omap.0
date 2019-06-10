From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] ARM: dts: am335x phytec boards: Fix cd-gpios active
 level
Date: Mon, 10 Jun 2019 05:10:16 -0700
Message-ID: <20190610121016.GX5447@atomide.com>
References: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
 <1558704003-393769-2-git-send-email-t.remmet@phytec.de>
 <20190610070732.GU5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190610070732.GU5447@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Schultz <d.schultz@phytec.de>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190610 07:08]:
> * Teresa Remmet <t.remmet@phytec.de> [190524 06:20]:
> > Active level of the mmc1 cd gpio needs to be low instead of high.
> > Fix PCM-953 and phyBOARD-WEGA.
> 
> Thanks I'll pick this patch into fixes.

And I'll apply the rest of the series into omap-for-v5.3/dt.

Thanks,

Tony
