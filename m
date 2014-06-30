From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 7/9] ASoC: omap: rx51: Add some error messages
Date: Mon, 30 Jun 2014 12:02:40 +0200
Message-ID: <20140630100238.GD4934@xo-6d-61-c0.localdomain>
References: <1398694047-28596-1-git-send-email-sre@kernel.org>
 <1398694047-28596-8-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398694047-28596-8-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sre@ring0.de>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi!

> Add more error messages making it easier to identify problems.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  sound/soc/omap/rx51.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

> +	if (err) {
> +		dev_err(card->dev, "Failed to add GPIOs\n");
> +		return err;
> +	}
>  
>  	return err;
>  }


As you'll return err, anyway, you don't need to do it inside the if()... OTOH it 
does not hurt.

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
