From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 22:58:57 +0530
Message-ID: <5d5443650811250928n49b133ddl955cd2cb0ef77e57@mail.gmail.com>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com>
	 <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:14072 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYKYR27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 12:28:59 -0500
Received: by yx-out-2324.google.com with SMTP id 8so38461yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 09:28:57 -0800 (PST)
In-Reply-To: <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Bill Gatliff <bgat@billgatliff.com>

Hi,

On Tue, Nov 25, 2008 at 10:29 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> Hi,
>
> TWL4030 and compatibles have 2 pulse-width modulation (PWM) generators
> (PWM0 and PWM1). They are used for backlight control and charger LED
> in pandora board. I wasn't able to find any drivers for them in
> linux-omap tree. Is there anyone working on these? If not, what would
> be the proper way to expose them? May be as LED driver?
> I saw lcd_omap*evm.c just write to LED PWM registers over i2c to
> control backlight, I wonder if I should just do the same.

Bill Gatliff (CCed here) already proposed PWM framework on
linux-arm-kernel and LKML, please follow that discussion.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
