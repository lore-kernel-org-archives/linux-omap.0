From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: dts: omap3: Remove needless interrupt-parent
 property
Date: Thu, 10 Aug 2017 09:38:17 -0700
Message-ID: <20170810163816.GH8569@atomide.com>
References: <41ab5d17-620e-34b6-bd1c-33ae7bb3234c@techveda.org>
 <1498546060-5742-1-git-send-email-karthik@techveda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498546060-5742-1-git-send-email-karthik@techveda.org>
Sender: linux-kernel-owner@vger.kernel.org
To: karthik@techveda.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sunil.m@techveda.org
List-Id: linux-omap@vger.kernel.org

* karthik@techveda.org <karthik@techveda.org> [170626 23:48]:
> From: Karthik Tummala <karthik@techveda.org>
> 
> All nodes inhert "interrupt-parent" property from root
> node. Removed the aforementioned property from usbhsohci,
> usbhsehci, ssi_port1, ssi_port2 nodes to avoid duplication.
> 
> Signed-off-by: Karthik Tummala <karthik@techveda.org>
> ---
> Changes for v2:
> - Made changes to subject & description as suggested by
>   Suniel Mahesh.

Applying into omap-for-v4.14/dt thanks.

Tony
