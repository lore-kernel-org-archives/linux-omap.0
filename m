From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 17:56:03 +0000
Message-ID: <20100217175602.GG2032@sirena.org.uk>
References: <4B7AE1AD.7080400@mlbassoc.com> <201002171226.05108.peter.ujfalusi@nokia.com> <4B7BC86C.8040905@mlbassoc.com> <201002171317.27896.peter.ujfalusi@nokia.com> <4B7BDAB1.3020503@mlbassoc.com> <20100217194501.7e49ac0c.jhnikula@gmail.com> <4B7C2C8F.9040703@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48331 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab0BQR4H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 12:56:07 -0500
Content-Disposition: inline
In-Reply-To: <4B7C2C8F.9040703@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On Wed, Feb 17, 2010 at 10:51:11AM -0700, Gary Thomas wrote:

> Thanks.  I'd really like to understand how to set things up to generate
> the data I see in TRM:
>   Figure 21-11 shows an example with 24 bits data (MSB first) and 8 padding bits at ?0?.
>
> This matches my CODEC.  Any clues?

Does your CODEC actually need the padding bits to be zero?  What you're
describing sounds an awful lot like 32 bit data that just has the LSB
ignored.
