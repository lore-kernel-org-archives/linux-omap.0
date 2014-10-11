From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/4] regulator: Add helper function to get
 "poweroff-source" property
Date: Sat, 11 Oct 2014 14:51:59 +0100
Message-ID: <CACxGe6vsec80SDQFvZxStEcm8i6wTpa2ve7-r=n13-vZUjarcA@mail.gmail.com>
References: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
 <CABgxDoL2cztT6Y0oodtk4Q4jaDc1Rtx_RokxC+f0XykSojrdyg@mail.gmail.com>
 <CACxGe6vmBSgGpJgJ51Ki5KbQO65GDw3kSGSxnswYMfE8OGj9gw@mail.gmail.com> <CABgxDoKo8RkM3etK7Yu+8vHQSWs-53wnZujF_QvXR0GJAwBfoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABgxDoKo8RkM3etK7Yu+8vHQSWs-53wnZujF_QvXR0GJAwBfoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: PERIER Romain <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 10, 2014 at 1:29 PM, PERIER Romain <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> What I'm more concerned about is the semantics of the property. What
>> do the generic code paths gain by standardizing this property? Is it
>> expected that
>
> We really need to come up with a standard property for this and document
> it rather than continuing to add individual device specific properties
> each time a driver adds poweroff capability,
> all doing the same thing (a lot of regulators driver, mfd drivers, soc
> specific drivers, power drivers already do that, that's very redudant)
> . This is a simple unification logic.

Yes, it's fine. I accidentally left that paragraph in when I sent my
reply. I started writing that concern, and then thought better of it.
The property is fine.

g.
