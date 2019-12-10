From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-sancloud-bbe: fix phy mode
Date: Tue, 10 Dec 2019 07:17:11 -0800
Message-ID: <20191210151711.GK35479@atomide.com>
References: <20191201170706.7173-1-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191201170706.7173-1-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mans Rullgard <mans@mansr.com> [191201 09:15]:
> The phy mode should be rgmii-id.  For some reason, it used to work with
> rgmii-txid but doesn't any more.

Applying into fixes thanks.

Tony
