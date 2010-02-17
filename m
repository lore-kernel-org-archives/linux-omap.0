From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 11:01:53 -0700
Message-ID: <4B7C2F11.3010008@mlbassoc.com>
References: <4B7AE1AD.7080400@mlbassoc.com> <201002171226.05108.peter.ujfalusi@nokia.com> <4B7BC86C.8040905@mlbassoc.com> <201002171317.27896.peter.ujfalusi@nokia.com> <4B7BDAB1.3020503@mlbassoc.com> <20100217194501.7e49ac0c.jhnikula@gmail.com> <4B7C2C8F.9040703@mlbassoc.com> <20100217175602.GG2032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:40647 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0BQSB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 13:01:58 -0500
In-Reply-To: <20100217175602.GG2032@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On 02/17/2010 10:56 AM, Mark Brown wrote:
> On Wed, Feb 17, 2010 at 10:51:11AM -0700, Gary Thomas wrote:
>
>> Thanks.  I'd really like to understand how to set things up to generate
>> the data I see in TRM:
>>    Figure 21-11 shows an example with 24 bits data (MSB first) and 8 padding bits at ?0?.
>>
>> This matches my CODEC.  Any clues?
>
> Does your CODEC actually need the padding bits to be zero?  What you're
> describing sounds an awful lot like 32 bit data that just has the LSB
> ignored.

I don't think it matters.  The real problem is how to get 24 bits
of data aligned to the right place in the 32 bit frame.  TRM implies
that the hardware can do this, I've just not figured out the magic...

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
