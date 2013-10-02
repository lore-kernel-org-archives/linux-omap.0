From: Jon Loeliger <jdl-CYoMK+44s/E@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Wed, 02 Oct 2013 08:22:58 -0500
Message-ID: <E1VRMOI-0006iA-TF@jdl.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com> <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com> <524AE4FB.4080906@baylibre.com> <E1VR1hx-0000C1-6J@jdl.com> <524BE66D.7060308@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <524BE66D.7060308-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> >
> > Benoit,
> >
> > Sorry, I meant to ask earlier but forgot.
> > Shouldn't this development be based on the
> > upstream DTC repository and not the in-kernel
> > copy of the DTC?
> 
> Eventually, yes,

We should *start* there, though.

> but here the main point is to discuss the schema that 
> will be used to defined bindings.
> In that case, the DTC patches code are mostly a proof of concept

Sure; all that is fine.

> using the Linux kernel as example.

Example?(*)  We shouldn't churn the kernel.

jdl

(*) In the sense that *this* Universe is just
    one example from all known Universes? :-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
