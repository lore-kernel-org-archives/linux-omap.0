From: Daniele Forsi <dforsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: sti: Add st-dwc3 devicetree bindings documentation
Date: Fri, 4 Jul 2014 14:25:24 +0200
Message-ID: <CAN_we7Mqm0ScULzCSNwmb46MAQNcfckSZ9+iH_3pCfv+VTyUMg@mail.gmail.com>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
	<1404472432-24764-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404472432-24764-3-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2014-07-04 13:13 GMT+02:00 Peter Griffin:

> +Required properties:
> + - compatible  : must be "st,stih407-dwc3"
> + - reg         : glue logic base address and USB syscfg ctrl register offest
> + - reg-names   : Should be "reg-glue" and "syscfg-reg".
> + - st,syscon    : should be phandle to system configuration node which
> +                 encompases the glue registers.
> + - resets       : phandle pointing to the system powerdown controller

minor knits:
s/offest/offset/
s/encompases/encompasses/
"Should" is upper case while all other lines in this block start with
a lower case letter;
two lines end with a full stop, three lines without;
colons the last lines do not align to the first three

-- 
Daniele Forsi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
