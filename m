From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 16:58:54 +0200
Message-ID: <56EAC62E.7020302@gmail.com>
References: <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
 <20160317004917.GA6750@earth> <56EA6326.4000702@gmail.com>
 <20160317130115.GU8413@pali> <56EAACF4.2040005@gmail.com>
 <20160317133313.GL9329@atomide.com> <56EAB62D.80803@gmail.com>
 <20160317143204.GM9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317143204.GM9329@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 17.03.2016 16:32, Tony Lindgren wrote:
>
> Seems like a bug to me. My bets are on the deferred probe related
> Peter posted.
>

I will test Peter's patch as well, however I really doubt internal 
pull-ups enabled by Nokia to be a bug - keep in mind there are (or at 
least were) enough devices on the field for such a bug to not remain 
unnoticed, esp if it directly affects the signal quality over the i2c bus.

>
> You can calculate the parallel resistor value of the weak internal
> pull with the 1k external pull :)

Sure :)

> If the i2c line pulls are wrong
> the signal quality won't match the spec and you will be getting
> i2c bus errors. If you can read and write to the i2c chip, this
> is not the issue.
>

And it seems stock kernel can read/write without problems with those 
pull-ups enabled.

However, lets continue the discussion after I have tested both the 
Peter's patch and internal pull-ups enabled.

Thanks,
Ivo
