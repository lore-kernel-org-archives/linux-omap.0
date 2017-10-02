From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am43xx-epos-evm: Enable SGX on EPOS boards
Date: Mon, 2 Oct 2017 07:52:50 -0700
Message-ID: <20171002145250.GN4394@atomide.com>
References: <20170918173130.17657-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170918173130.17657-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170918 10:32]:
> From: Yogesh Siraswar <yogeshs@ti.com>
> 
> The SGX IP is valid and usable on AM438x devices, enable this
> here.

This still produces:

arch/arm/boot/dts/am43x-epos-evm.dts:796.1-5 Label or
path sgx not found

The parent node for the interconnect target module can be added
the same ways as done in "ARM: dts: Add nodes for missing omap4
interconnect target modules". But the child sgx device binding
still needs to be documented before we can add those.

Regards,

Tony
