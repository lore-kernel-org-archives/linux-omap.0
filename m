From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: OMAP: Beagle: revision detection
Date: Fri, 13 Aug 2010 15:44:54 +0300
Message-ID: <20100813154454.aca470ee.jhnikula@gmail.com>
References: <1281702070-10525-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62954 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934206Ab0HMMo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 08:44:58 -0400
Received: by eyg5 with SMTP id 5so110274eyg.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 05:44:56 -0700 (PDT)
In-Reply-To: <1281702070-10525-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Fri, 13 Aug 2010 07:21:08 -0500
Robert Nelson <robertcnelson@gmail.com> wrote:

> +	/* Older U-Boot's such as 2009.01-dirty don't have the pins 
> +	 * muxed correctly to use the generic gpio_direction_input();
> +	 */
> +	omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
> +

Comment (and code) is wrong: gpio_direction_input is still required to
setup pin direction and letting the gpiolib to setup internal data
structures properly. I.e. both mux setup and gpio_direction_input are
required.


-- 
Jarkko
