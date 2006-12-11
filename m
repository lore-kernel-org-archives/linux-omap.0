From: tony@atomide.com
Subject: Re: [patch 2.6.19-omap-git] osk+mistral backlight, power
Date: Mon, 11 Dec 2006 14:27:23 -0800
Message-ID: <20061211222722.GH31722@atomide.com>
References: <20061207064657.CC5D31E7779@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061207064657.CC5D31E7779@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061206 22:47]:
> Mistral-specific:
>  
>   - Add PWL-driven LCD backlight device
> 
>   - Apply power to the board even when the LCD isn't configured; things
>     like EEPROM, temperature sensor, and wakeup switch depend on it.
> 
> Generic backlight driver updates:
> 
>   - Don't oops on misconfigured platform device
> 
>   - Writing to /sys/class/backlight/omap-bl/brightness now works

Pushing these as two patches.

Tony
