From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 3/7] ARM: OMAP4: Add timer clock aliases for device-tree
Date: Wed, 19 Sep 2012 23:55:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192355220.14850@utopia.booyaka.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <1347579091-3794-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1347579091-3794-4-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 13 Sep 2012, Jon Hunter wrote:

> For OMAP4, the dmtimers are located in the Wake-up, ABE and Peripheral (PER)
> power domains. Hence, when the dmtimer is configured to use the "timer_sys_ck"
> as its functional clock the actual clock used is different depending on whether
> the clock is in the Wake-up, ABE or PER domain. So when we look-up the dmtimer's
> "timer_sys_ck" we need to specify the timer device name as well as clock alias
> to find the right clock.
> 
> Currently, the device names for the timers have the format "omap_timer.X" where
> X is the timer instance number. When using to device tree, the format of the
> device name created by device-tree is different and has the format
> "<reg-address>.<device-name>" (this is assuming that the device-tree "reg"
> property is specified). This causes the look-up for the OMAP4 "timer_sys_ck" to
> fail. To fix this add new timer clock alias for using device-tree.
> 
> Please note that adding a 2nd set of clock aliases for the same clocks to only
> temporary until device-tree migration is complete. Then we can remove the legacy
> aliases. Hence, I have marked the legacy aliases with a "TODO" to remove them.
> 
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>

Thanks, queued for 3.7.

- Paul
