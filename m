From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Mon, 1 Apr 2013 21:01:55 +0300
Message-ID: <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
	<CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
	<alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
	<CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
	<alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com>
	<CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
	<CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
	<alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:59288 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758157Ab3DASB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 14:01:56 -0400
In-Reply-To: <alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, balbi@ti.com

Paul, can you please try to comment out change related to Rx line
(granulation one). That's only Rx line related change in the patch.

On Mon, Apr 1, 2013 at 8:09 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 1 Apr 2013, Alexey Pelykh wrote:
>
>> Please, correct me if I'm wrong, you're experiencing issues on Tx, or
>> Rx direction? You've said that characters are echoed incorrectly, but
>> haven't mentioned in what direction issue appears?
>
> The problem seems to be on the Rx path.  If I 'cat' a file, it's
> transmitted without hesitation.  But when I paste in this Simpsons quote
> into the serial console via X:
>
> -----
> Mr. Burns: A lifetime of working with nuclear power has left me with a healthy green glow... and left me as impotent as a Nevada boxing commissioner.
> -----
>
> ... everything up to the end of "boxing" is echoed immediately, and then
> "commissioner." stutters its way across the screen over the next five
> seconds.
>
>
> - Paul
