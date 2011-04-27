From: Dmitry Artamonow <mad_soft-aPYA7nAdAYY@public.gmane.org>
Subject: Re: [Regression?] Removed regulator support in ehci-omap
Date: Wed, 27 Apr 2011 15:51:33 +0400
Message-ID: <20110427115133.GA16447@rainbow>
References: <20110411093214.GA18215@rainbow>
 <4DA3350E.2060400@gmail.com>
 <BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com>
 <112ef82aebc719ef25cde126f2014ebc@mail.gmail.com>
 <20110412040420.GB25239@rainbow>
 <bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com>
 <4DB0D58E.4030508@signal11.us>
 <8712165194c49f0b4d8c1bd1fe717b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8712165194c49f0b4d8c1bd1fe717b8a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12:07 Sun 24 Apr     , Keshava Munegowda wrote:
> I have posted the patches on April 22, 2011.
> If possible I request you to test this.

Hi, Keshava!

Sorry for delay - it took some time to find _where_ exactly you have posted
the patch (thanks to Alan for giving the link). Anyway, it[1] seems to work
as advertised (I also applied GPIO polarity fix [2] and board file patch[3],
all on top of 2.6.39-rc4) - at least stuff in /sys/class/regulator looks right,
and USB devices are detected. There's probably something still missing in the
board file, as USB detection starts to work only if I booted TI's kernel
(that came with board) before trying patched 2.6.39-rc4, but I hope that
this isn't connected to this regulators issue.

[1] http://www.spinics.net/lists/linux-usb/msg45618.html
[2] https://lkml.org/lkml/2011/4/14/45
[3] http://arago-project.org/git/projects/?p=linux-omap3.git;a=commitdiff;h=2ec611981ad76256d5034ae36708d807142bed1c

-- 
Best regards,
Dmitry "MAD" Artamonow

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
