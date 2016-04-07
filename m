From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in of_dev_lookup
Date: Wed, 6 Apr 2016 23:52:24 -0500
Message-ID: <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com> <20160401214053.GQ9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160401214053.GQ9329-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 1, 2016 at 4:40 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160401 14:37]:
>> We currently try to match of_dev_auxdata based on compatible,
>> IO address, and device name. But in some cases we have multiple
>> instances of drivers that can use the same auxdata.
>>
>> Let's add an additional secondary lookup for generic compatible
>> match for auxdata if no device specific match is found. This does
>> not change the existing matching, and still allows adding device
>> specific auxdata.
>>
>> This simplifies things as specifying the IO address and device
>> name is prone errors as it requires maintaining an in kernel
>> database for each SoC.
>
> And here's what I can apply later on to get rid of some
> ifdeffery.
>
> I'm also planning to move some of the legacy omap hwmod
> functionality into proper device drivers, so can generic
> pdata for that too.

Why can't the platform data be moved into the driver given that it
appears to be only SoC family specific? Auxdata was somewhat intended
to be temporary. It appears there is already some per compatible match
data for these OMAP parts in the driver.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
