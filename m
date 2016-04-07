From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] regulator: twl: Provide of_map_mode for twl4030
Date: Thu, 7 Apr 2016 12:57:45 -0500
Message-ID: <20160407175745.GK32257@rob-hp-laptop>
References: <20160404222638.GM2350@sirena.org.uk>
 <1459835974-31664-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459835974-31664-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: broonie@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tony@atomide.com, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2016 at 08:59:34AM +0300, Ivaylo Dimitrov wrote:
> of_map_mode is needed so to be possible to set initial regulators mode from
> the board DTS. Otherwise, for DT boot, regulators are left in their default
> state after reset/reboot. Document device specific modes as well.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  .../bindings/regulator/twl-regulator.txt           |  6 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/regulator/twl-regulator.c                  | 22 +++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
