From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: dts: am: Rename "ocmcram" node to "sram"
Date: Tue, 22 Oct 2019 09:31:40 -0700
Message-ID: <20191022163140.GZ5610@atomide.com>
References: <20191021161752.21502-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191021161752.21502-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzk@kernel.org> [191021 09:39]:
> The device node name should reflect generic class of a device so rename
> the "ocmcram" node and its children to "sram".  This will be also in
> sync with upcoming DT schema.  No functional change.

Applying into omap-for-v5.5/dt thanks.

Tony
