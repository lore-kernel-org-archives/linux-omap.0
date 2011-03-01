From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [TLV320AIC23] [AM3517EVM][AUDIO] codec name mis-match in
 soc_bind_dai_link
Date: Tue, 1 Mar 2011 12:42:43 +0200
Message-ID: <20110301124243.6c329c74.jhnikula@gmail.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370776EC3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48722 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1CAKl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 05:41:28 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370776EC3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On Tue, 1 Mar 2011 15:22:29 +0530
"Koyamangalath, Abhilash" <abhilash.kv@ti.com> wrote:

> Now, if I change the dai-link->codec_name to force-match by appending 2-001a to the codec_name in (sound/soc/omap/am3517evm.c):
> 	static struct snd_soc_dai_link am3517evm_dai = {
> 			:
>       	  .codec_name = "tlv320aic23-codec.2-001a ",
> 			:
> 	};
> 
> the registration proceeds smoothly and I can see device nodes getting created. 
> Since now there is no way to provide a customized i2c device name to a client device (or so I believe), what could be the best solution to this problem ?
> 
The fix above. Care to check also osk5912.c?


-- 
Jarkko
