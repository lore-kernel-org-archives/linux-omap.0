From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/9] regulator: tps65217: Enable suspend configuration
Date: Thu, 23 Jun 2016 16:02:24 +0530
Message-ID: <576BBAB8.9010705@ti.com>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
 <20160621190848.GF28202@sirena.org.uk> <576A64EA.4000607@ti.com>
 <20160622101611.GI28202@sirena.org.uk> <576A67D9.6080707@ti.com>
 <20160623102634.GX28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160623102634.GX28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Thursday 23 June 2016 03:56 PM, Mark Brown wrote:
> On Wed, Jun 22, 2016 at 03:56:33PM +0530, Keerthy wrote:
>
>> I will allocate memory for TPS65217_NUM_REGULATOR strobes during regulator
>> probe. Is this approach okay?
>
> It should be I think.  Some more comments or changelog explaining what's
> going on with the sequencing would also help.

Sure. I will do that. Thanks for the feedback.

>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
