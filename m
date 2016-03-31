From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Documentation: devicetree: bindings: regulator:
 palmas-pmic.txt
Date: Thu, 31 Mar 2016 09:15:42 -0500
Message-ID: <20160331141542.GA17373@rob-hp-laptop>
References: <1459255363-21101-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459255363-21101-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, spatton-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 29, 2016 at 06:12:43PM +0530, Keerthy wrote:
> From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> 
> Adding support for the tps659038 pmic so it doesn't generate a warning
> when running the patch check script to
> Documentation/devicetree/bindings/regulator/palmas-pmic.txt
> 
> Adding a note that the tps659037 device is a OTP spin of the
> tps659038 pmic and device compatible.
> 
> Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/regulator/palmas-pmic.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
