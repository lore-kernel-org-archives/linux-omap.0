From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Audio on OMAP3
Date: Mon, 10 Aug 2009 07:19:33 -0600
Message-ID: <4A801E65.8030305@mlbassoc.com>
References: <4A7F068D.6090407@mlbassoc.com> <20090809190452.GC4390@sirena.org.uk> <4A7F32CA.8000108@mlbassoc.com> <20090810095156.GA24947@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:3680 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbZHJNTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 09:19:33 -0400
In-Reply-To: <20090810095156.GA24947@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org

Mark Brown wrote:
> On Sun, Aug 09, 2009 at 02:34:18PM -0600, Gary Thomas wrote:
> 
>> Thanks.  How is this normally configured - ALSA or OSS?
> 
> It's all ALSA.  There is some OSS emulation for ALSA.
> 

Sorry for being dense, but I'm just trying to understand how to
get this going.  I turned on the SOC+ALSA support (there didn't
seem to be an easy way to configure just the TWL4030 driver) and
I got this:

Advanced Linux Sound Architecture Driver Version 1.0.20.
Platform driver 'soc-audio' needs updating - please use dev_pm_ops
No device for DAI AD73311
Asahi Kasei AK4104 ALSA SoC Codec Driver
No device for DAI AK4535
Cirrus Logic CS4270 ALSA SoC Codec Driver
No device for DAI PCM3008 HiFi
No device for DAI SSM2602
No device for DAI tlv320aic23
No device for DAI tlv320aic3x
No device for DAI twl4030
No device for DAI twl4030 Voice
No device for DAI UDA134X
No device for DAI UDA1380
No device for DAI UDA1380
No device for DAI UDA1380
No device for DAI WM8510 HiFi
No device for DAI WM8728
No device for DAI WM8750
No device for DAI WM8971
No device for DAI WM8990 ADC/DAC Primary
ALSA device list:
  No soundcards found.

Is there more configury/setup required, beyond just enabling the drivers?
Is there an example board that uses this?
Is the code in the mainline linux-omap tree?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
