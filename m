From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 17:44:26 +0530
Message-ID: <5d5443650812150414x43716c67v6349e74f922d2de1@mail.gmail.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:37363 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYLOMO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 07:14:27 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2466624rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 04:14:26 -0800 (PST)
In-Reply-To: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, juha.yrjola@solidboot.com

Hi Tony

On Mon, Dec 15, 2008 at 5:38 PM, Jani Nikula
<ext-jani.1.nikula@nokia.com> wrote:
> Add new function omap_update_gpio_switch() to support dynamically
> changing the GPIO switch notify callback functions and debounce
> timeouts.
>
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

Not related to this patch, but why not we convert this omap specific
gpio switch code into generic switch framework and attach gpios to
that switch framework, other arm-linux platforms seems to also use
such home-brew frameworks for this functionality it seems.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
