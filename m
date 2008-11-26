From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 10:34:41 -0800
Message-ID: <200811261034.42356.david-b@pacbell.net>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com> <20081126110854.GA6234@sirena.org.uk> <20081126134028.b3c6aa46.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:26672 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752296AbYKZSeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 13:34:50 -0500
In-Reply-To: <20081126134028.b3c6aa46.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>
Cc: ext Mark Brown <broonie@sirena.org.uk>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Jarkko Nikula wrote:
> And as a first step, I recommend to start merging only those EVM & SDP
> boards with Beagle since they seems to be most close to each other.
> 
> Even the Overo seems to be close also, it was discussed earlier to keep
> it separated now since Steve was going to send some new features into
> it.

This seems to focus on just the McBSP channel out of the OMAP ...
except that it hides (in that nasty #ifdeffery) the codec data.

The fact that it doesn't allow EAC or a McBSP successor says
to me it's not really "general".  Heck ... it even hard-wires
McBSP2, preventing another channel from being used.  So IMO
a different name would be appropriate...

Re TWL4030 codec configuration ... I count three microphone
input channels not used on Beagle, plus a speaker output
and some other stuff.  So it's obvious that something which
works on Beagle won't handle more interesting configurations
of that audio support.  


Plus, if there's going to be a board-specific platform device
created, and stuffed with data like codec descriptions and
configuration data ... that's what arch/arm/mach-*/board-*.c
files are for.

I'm told that the ASoC stuff "should" go in a separate ASoC
area for some reason.  That still makes no good sense to me,
so if there's a brief explanation as to why it's done that
way, please fling me a URL.  :)

- Dave

