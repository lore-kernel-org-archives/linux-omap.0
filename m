From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v5 02/12] ASoC: davinci-evm: Add device tree binding
Date: Tue, 22 Oct 2013 19:41:00 +0300
Message-ID: <5266AA9C.2020907@ti.com>
References: <cover.1382110089.git.jsarha@ti.com> <66c21e66320e30453e6deded0f37ef582b4fba7c.1382110089.git.jsarha@ti.com> <20131022110147.GA9388@sirena.org.uk> <52666EE3.8070607@ti.com> <20131022123923.GF9388@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34421 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507Ab3JVQlL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Oct 2013 12:41:11 -0400
In-Reply-To: <20131022123923.GF9388@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, joelf@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

On 10/22/2013 03:39 PM, Mark Brown wrote:
> It would look a good deal less odd which is useful in itself; the best
> thing would be if they could both use the same driver which uses both
> platform and DT data.

I see. To be honest the whole non DT part looks pretty hairy to me too, 
but I can not clean it up because I do not have access to the relevant HW.

Would it look better to you if I would use module_platform_driver() 
macro inside #ifdef CONFIG_OF and put the module_init() and 
module_exit() into #else branch?

Best regards,
Jyri
