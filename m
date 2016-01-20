From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] HSI: nokia-modem: add n950 and n9 support
Date: Wed, 20 Jan 2016 10:49:19 -0600
Message-ID: <20160120164919.GA29749@rob-hp-laptop>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453045749-22642-4-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jan 17, 2016 at 04:49:07PM +0100, Sebastian Reichel wrote:
> The Nokia N950 and Nokia N9 also have a SSI connected
> modem, which use the same protocols as the Nokia N900,
> but with slightly other GPIO setup and increased link

"slightly other" does not make sense.

> speed (96000 kbps instead of 55000 kbps).
> 
> Since it's unclear, if the N950 and the N9 use exactly
> the same modem, each of them gets their own compatible
> string.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  Documentation/devicetree/bindings/hsi/nokia-modem.txt | 12 +++++++-----
>  drivers/hsi/clients/nokia-modem.c                     |  2 ++
>  2 files changed, 9 insertions(+), 5 deletions(-)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
