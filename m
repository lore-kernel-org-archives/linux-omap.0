From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 10:51:11 -0700
Message-ID: <4B7C2C8F.9040703@mlbassoc.com>
References: <4B7AE1AD.7080400@mlbassoc.com>	<201002171226.05108.peter.ujfalusi@nokia.com>	<4B7BC86C.8040905@mlbassoc.com>	<201002171317.27896.peter.ujfalusi@nokia.com>	<4B7BDAB1.3020503@mlbassoc.com> <20100217194501.7e49ac0c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:39142 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0BQRvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 12:51:15 -0500
In-Reply-To: <20100217194501.7e49ac0c.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On 02/17/2010 10:45 AM, Jarkko Nikula wrote:
> On Wed, 17 Feb 2010 05:01:53 -0700
> Gary Thomas<gary@mlbassoc.com>  wrote:
>
>>> After looking at the TRM of OMAP, the sDMA has support for 8, 16 an=
d 32 bit data
>>> types. So I'm not really sure how to configure McBSP and sDMA in ca=
se of 24 bit
>>> packed format.
>>> I would go with a trial and error method and find it out how it is =
working...
>>>
> So it looks that the memory representation must be 32-bit.
>
>> How about sending padded data (24 bits in 32) which is what my
>> CODEC wants anyway?  Would this be easier to set up?  How?
>>
>> (Again, I'm a bit fuzzy on how to tell omap_pcm_prepare that I
>> need to be moving 24 or 32 bit chunks)
>>
> Internal representation and link configuration are separate things:
>
> DMA<->  McBSP rx/tx reg<- [FIFO] ->  McBSP receiver/transmitter
>
> As Peter found, due the DMA and McBSP FIFO, the DMA configuration mus=
t
> be 32-bit. But I suppose the McBSP receiver/ransmitter could be
> configured to transmit only 24-bits.
>
> The OMAP35x Applications Processor Multi-Channel Buffered Serial Port
> (McBSP) TRM (SPRUFD1C) seems to have some examples for different data
> lengths than internal word length. Worth to look and try with trial a=
nd
> error method using oscilloscope :-)

Thanks.  I'd really like to understand how to set things up to generate
the data I see in TRM:
   Figure 21-11 shows an example with 24 bits data (MSB first) and 8 pa=
dding bits at =910=92.

This matches my CODEC.  Any clues?

BTW, I was able to set things up for 32 bit PCM data, based on
the email thread you pointed at.  Still need the funky 24 bit
stuff though.

--=20
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
