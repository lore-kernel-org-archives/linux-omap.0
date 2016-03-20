From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/3] pwm: pwm-tiehrpwm: Update dt binding document to
 use generic node name
Date: Sat, 19 Mar 2016 19:40:18 -0500
Message-ID: <20160320004018.GA7611@rob-hp-laptop>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
 <1458263723-25770-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458263723-25770-4-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 17, 2016 at 08:15:23PM -0500, Franklin S Cooper Jr wrote:
> Now that the node name has been changed from ehrpwm to pwm the document
> should show this proper usage. Also change the unit address in the example
> from 0 to the proper physical address value that should be used.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 3 changes:
> N/A
> 
> Version 2 changes:
> Changed the unit address for da850 to match the value in the reg property.
> 
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
