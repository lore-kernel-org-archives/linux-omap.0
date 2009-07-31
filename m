From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 3/3 v2] ASoC: add support for Amstrad E3 (Delta)
 machine
Date: Fri, 31 Jul 2009 15:27:13 +0200
Message-ID: <4A72F131.7010806@tis.icnet.pl>
References: <200907291318.54897.jkrzyszt@tis.icnet.pl>	<20090731095234.GB10844@rakim.wolfsonmicro.main>	<4A72DC71.6020904@tis.icnet.pl> <20090731131647.012afb23@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20090731131647.012afb23@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jhnikula@gmail.com>, Jonathan McDowell <noodles@earth.li>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>
List-Id: linux-omap@vger.kernel.org

Alan Cox wrote:
>>> Furthermore, I am still thinking about renaming the ldisc with a more 
>>> generic name. That way, it could be probably reused by other similiar 
>>> implementations. As long as the ldisc is registered from a board 
>>> specific code, it should not interfere with other implemnetations 
>>> reusing the same ldisc number, even if compiled in side by side.
>> Any objections on renaming ldisc from N_AMSDLETA to N_V253?
> 
> None
> 

Thanks, will resubmit as patch 2/3 v2 and 3/3 v3 then.

Janusz
