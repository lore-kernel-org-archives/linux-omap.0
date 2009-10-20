From: Andrejs Cainikovs <andrejsc@globalautomationsystems.com>
Subject: Re: OMAP2420-HS flashing question
Date: Tue, 20 Oct 2009 17:28:45 +0300
Message-ID: <4ADDC91D.3010400@globalautomationsystems.com>
References: <4ADCA2BF.3020105@globalautomationsystems.com> <e1a3109c0910200043n119316d4v60e28f7a7231d172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from b124.csc.lv ([193.138.189.124]:56654 "EHLO
	mail.globalautomationsystems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbZJTO2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 10:28:42 -0400
In-Reply-To: <e1a3109c0910200043n119316d4v60e28f7a7231d172@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shankar Ganesh <shankarganeshk@gmail.com>
Cc: linux-omap@vger.kernel.org

Shankar Ganesh wrote:
> On Mon, Oct 19, 2009 at 1:32 PM, Andrejs Cainikovs 
> <andrejsc@globalautomationsystems.com 
> <mailto:andrejsc@globalautomationsystems.com>> wrote:
>
>     Dear all,
>
>     I've googled that OMAP HS are checking some kind of signature
>     (applications should be signed with the special tool (OST Tools))
>     so the developer must own the keys for particular CPU? It is
>     possible to turn off the HS option so I'll be able to work with
>     non-signed binaries?
>     The problem is that I want to get kernel running on custom
>     OMAP2420-HS board but have no keys.
>
>
>
> Try CSST [1] for 2430 , having signing support for 24xx. There are 
> default keys available with the release. You may go through quick 
> start guide  (available with binary) for further info.
>
> [1] 
> http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?templateId=6123&navigationId=12013&contentId=4581 
> <http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?templateId=6123&navigationId=12013&contentId=4581>  
>
Thanks Shankar,

This custom board is the part of dead Nokia phone, I really doubt it 
will work with default keys. Anyway, it is worth a try...

Regards,
Andrejs Cainikovs.
