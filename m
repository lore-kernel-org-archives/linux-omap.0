From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04a5: Replace LXR reference with a
 local one
Date: Thu, 7 Feb 2019 09:27:24 -0800
Message-ID: <20190207172724.GD5720@atomide.com>
References: <20190129144518.9744-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129144518.9744-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jonathan Neuschäfer <j.neuschaefer@gmx.net> [190129 06:46]:
> There's no need to use an external link when the file is already here.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> Alternatively, I could change the link to https://elixir.bootlin.com
> (the successor of lxr.free-electrons.com), but this solution seemed
> simpler.

Yeah makes sense to me. Applying into omap-for-v5.1/dt
thanks.

Tony
