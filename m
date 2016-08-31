From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: Applied "mfd: tps65218: add version check to the PMIC probe" to
 the regulator tree
Date: Wed, 31 Aug 2016 18:57:01 +0100
Message-ID: <20160831175701.GA5783@n2100.arm.linux.org.uk>
References: <1466412218-5906-8-git-send-email-j-keerthy@ti.com>
 <E1bXZjd-0000YR-7n@debutante>
 <20160831083114.GP10121@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160831083114.GP10121@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 31, 2016 at 09:31:14AM +0100, Lee Jones wrote:
> On Wed, 10 Aug 2016, Mark Brown wrote:
> 
> > The patch
> > 
> >    mfd: tps65218: add version check to the PMIC probe
> 
> Why did you take this patch?

I think folk need to start to understand the purpose of the To: and Cc:
lines in emails.

To: means you're sending the message _to_ the recipient, expecting them
to be the _primary_ receiver of the message, and to _process_ the message
in some way.  In the case of a patch, that may be applying the change.

Cc: means you're providing the recipient with a copy of the message, "for
their information" and you're not expecting them to take action.

If you think that there's no difference between To: and Cc: then ask
yourself this question: what's the point of having the two headers,
why not list all recipients under one single header.

Mark was in the To: line, therefore it is perfectly reasonable for him
to apply the patch when it gets acked, since the original author sent
it _TO_ Mark implicitly asking him to apply it.

If you have a problem with that, then you need to say something in
reply to the patch, or you need to instruct folk who send patches for
bits of your subsystem not to place others in the To: field who may
pick up the patch.

However, there is a tendency with some people's mailers (including
yours) which keeps the recipients of the To: and Cc: from the message
being replied to, and copies them to the reply as-is.  That totally
screws up the meaning of the To: and Cc: headers, and is really
really really really annoying for people who are in the To: field
but who aren't being asked to do anything in the replies.  (Fix your
bloody mailer not to do this please!)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
