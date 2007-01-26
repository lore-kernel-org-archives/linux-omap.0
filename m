From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warnings in leds-omap-pwm.c
Date: Fri, 26 Jan 2007 13:33:49 -0800
Message-ID: <20070126213349.GJ29286@atomide.com>
References: <45B1BFB4.5000503@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45B1BFB4.5000503@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070119 23:09]:
> 
> ARM: OMAP: Fix warnings in leds-omap-pwm.c:
> 
> drivers/leds/leds-omap-pwm.c: In function 'omap_pwm_led_probe':
> drivers/leds/leds-omap-pwm.c:260: warning: ignoring return
> value of 'class_device_create_file', declared with attribute
> warn_unused_result
> drivers/leds/leds-omap-pwm.c:262: warning: ignoring return
> value of 'class_device_create_file', declared with attribute
> warn_unused_result

Pushing today.

Tony
