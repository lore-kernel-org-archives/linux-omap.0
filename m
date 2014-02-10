From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 0/7] omap hwspinlock dt support
Date: Mon, 10 Feb 2014 13:27:39 -0600
Message-ID: <52F9282B.5000702@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389658764-39199-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Mark,

On 01/13/2014 06:19 PM, Suman Anna wrote:
> Hi,
>
> This is an updated series mainly addressing Mark Rutland's comments
> about hwlock specifier being always one-cell. The series adds the
> support for #hwlock-cells property and adds a simple default OF
> translate function.
>
> The DTS patches from previous series have already been merged, and
> needs this property to be added. This is handled in a separate series
> that only deals with OMAP hwspinlock DTS patches.
>
> The series, along with the DTS patches, is tested on top of v3.13-rc8
> plus Tero's v13 clock DT series and Tony's 3.14 staged branches. The
> validation on OMAP5, DRA7, AM437 requires Tero's series with couple of
> additional base patches for AM43xx. AM43xx functionality needs a hwmod
> fix [1] for creating the associated omap_device as well.
>

Can you please take a look at this series and give your ack on the 
bindings if you do not have any further comments? The only comments so 
far are from Bjorn on the OF helpers.

regards
Suman
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
