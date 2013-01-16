From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: McBSP functions not exported
Date: Wed, 16 Jan 2013 09:44:02 +0200
Message-ID: <20130116094402.251b13fbe83ca5c172bfac7d@bitmer.com>
References: <20130111114846.00005679@unknown>
	<50F010CF.8020808@ti.com>
	<ebad79c2234bac82958b7a1deea3ae55@localhost>
	<50F3C648.60101@ti.com>
	<f358e8045003700c83717ce3f7bc1932@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:51083 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758611Ab3APH7H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 02:59:07 -0500
In-Reply-To: <f358e8045003700c83717ce3f7bc1932@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Barker <paul@paulbarker.me.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org

Hi

On Tue, 15 Jan 2013 17:43:54 +0000
Paul Barker <paul@paulbarker.me.uk> wrote:

> I'm going to go back to using kernel 3.2 and check that this actually 
> works
> with the McBSP. If it does, how much hassle is it to export the 
> required symbols
> in more recent kernels? I'll happily write the patch, I just don't want 
> to
> introduce too much more maintenance overhead going forward.
> 
Quick idea that came to my mind. Hack and I don't know how feasible it is but would it be possible to make that ADC as a simple ASoC codec driver in your usecase? I.e. using ALSA API for high-rate ADC measurements and reuse existing serial link and dma drivers.

Anyway I think high-rate ADC falls in gray area in kernel currently. drivers/iio/ seems to not cover them and does not match exactly with ASoC either.

-- 
Jarkko
