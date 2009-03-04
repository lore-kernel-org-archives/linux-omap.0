From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 2/2] ASoC: Add headset jack detection for
	SDP3430	machine driver
Date: Wed, 4 Mar 2009 14:33:45 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6E382@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6E1B6@dlee07.ent.ti.com>
	<20090304190716.GB6420@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090304190716.GB6420@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> > +	ret = snd_soc_jack_new(&snd_soc_sdp3430, "SDP3430 headset jack",
> > +				SND_JACK_HEADSET, hs_jack);
> > +	if (ret)
> > +		return ret;

> This leaks the jack.

If hs_jack is declared as a direct static variable instead, then no mem
leaks, isn't it? Or do you mean to clean the hs_jack if any error?

-Misa
