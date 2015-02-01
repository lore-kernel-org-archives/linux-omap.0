From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bq2415x_charger.c: battery is discharged (fast, 224mA) when it
 should be charged
Date: Sun, 1 Feb 2015 21:56:03 +0100
Message-ID: <20150201205603.GA23044@amd>
References: <20150201094702.GA21628@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150201094702.GA21628@amd>
Sender: linux-pm-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sun 2015-02-01 10:47:02, Pavel Machek wrote:
> Hi!
> 
> I connected N900 with full battery using USB. For some reason, charge
> limit was set to 100mA, battery was "full" and was discharging:
> 
> root@n900:/my/tui/ofone# ./tefone
> Ready.
> Battery  4.017 V  4.039 V  81 %  0 %  0 / 0 / 2056 mAh  Full -242.224 / 550 / 100  mA
> 
> I adjusted the current limit, but got no change, battery is still
> discharging, fast:
> 
> root@n900:/my/tui/ofone# echo 500 > /sys/class/power_supply/bq24150a-0/current_limit
> root@n900:/my/tui/ofone# ./tefone
> Ready.
> Battery  3.994 V  4.034 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -251.506 / 550 / 500  mA
> Battery  4.0 V  4.037 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -223.125 / 550 / 500  mA
> Battery  4.005 V  4.037 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
> Battery  3.994 V  4.037 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
> Battery  4.023 V  4.037 V  81 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
> Battery  4.011 V  4.037 V  80 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
> Battery  3.994 V  4.031 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -256.504 / 550 / 500  mA
> Battery  3.994 V  4.029 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -224.017 / 550 / 500  mA
> Battery  3.988 V  4.029 V  77 %  0 %  0 / 0 / 2056 mAh  Full   -224.731 / 550 / 500  mA
> Battery  4.005 V  4.023 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -223.66 / 550 / 500  mA
> 
> I'm getting a lot of
> 
> [  208.037719] bq27x00-battery 2-0055: battery is not calibrated! ignoring capacity values
> [  238.038024] bq27x00-battery 2-0055: battery is not calibrated! ignoring capacity values
> 
> messages, that's why all the 0s in battery information dump.
> 
> Any ideas?

Reset kicked the charger back into the charging mode:

root@n900:/sys/class/power_supply/bq24150a-0# echo reset > mode
root@n900:/sys/class/power_supply/bq24150a-0# cat mode
auto (host)
root@n900:/sys/class/power_supply/bq24150a-0#

Battery  4.017 V  4.037 V  81 %  0 %  0 / 0 / 2056 mAh  Charging -109.42 / 650 / 500  mA
Battery  4.017 V  4.039 V  81 %  0 %  0 / 0 / 2056 mAh  Charging -103.173 / 650 / 500  mA

...and discharge current reduced. I tried adjusting current limit, but
it still discharges at 100mA (with screen on).

USB extension cable was probably part of a problem. It works better
with n900 plugged in directly into the PC.

(But it still will not terminate the charge:

Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   13.03 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   13.03 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   10.888 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   1.249 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   10.353 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   9.639 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   10.71 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   7.497 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   9.639 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   6.247 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   5.533 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   4.284 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   4.284 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   3.927 / 650 / 500  mA
)


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
