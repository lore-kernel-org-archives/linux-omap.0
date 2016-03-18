From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Fri, 18 Mar 2016 17:56:07 +0200
Message-ID: <56EC2517.7030301@gmail.com>
References: <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com> <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com> <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth> <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160318150404.GA30829@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


Hi,

On 18.03.2016 17:04, Sebastian Reichel wrote:
> Did you by chance also test adding a delay after setting the power
> gpio? According to the datasheet:
>
> Start-up time from shutdown: typical 5ms
>

:)

if (data->power_gpio) {
	dev_err(&tpa6130a2_client->dev,
		"!!!!!!!!!!!! GPIO SET: %d\n", ret);
	mdelay(10);
	gpiod_set_value(data->power_gpio, 1);
	mdelay(10);
}

Ivo
