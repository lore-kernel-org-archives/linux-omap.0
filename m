From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Thu, 18 Jun 2009 13:40:56 +0200
Message-ID: <4A3A27C8.60005@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl>	<20090608094028.415e6ec3.jhnikula@gmail.com>	<4A2E7921.7090200@tis.icnet.pl>	<4A364B1A.5040905@tis.icnet.pl>	<20090615181633.4570426f.jhnikula@gmail.com>	<4A37AFA9.4080403@tis.icnet.pl> <20090618090712.8f8ecd53.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47511 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbZFRLk6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2009 07:40:58 -0400
In-Reply-To: <20090618090712.8f8ecd53.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Jarkko Nikula wrote:
> Hmm, recall, did you try hacking the ASoC driver at the same commit
> d8376cc482b241701f7606c81ad578b90853e175 where older driver still
> exists and works? There has been ASoC OMAP fixes and changes since
> then but nothing which can explain why it doesn't work now for 1510.
> 
> There we would know that clock framework, register access etc. works for
> McBSP on 1510.

Yes, after realizing that possible lack of OMAP1510 McBSP1/3 / DSP 
support in the mainline tree could be the reason of my problem, I got 
back to omap tree. First I retried the new driver on commit 
90e758af52ba803cba233fabee81176d99589f09 and confirmed the prevoiusly 
seen hangup. I found that it was omap_mcbsp_request() never returning 
back from.

Then I retired the same on the commit 
d8376cc482b241701f7606c81ad578b90853e175 and got similiar hangup. Next, 
I moved mcbsp initialization to a boot time hook and finally heard a 
sound and got my first DMA interrupt!

So it seams I have finally managed to take all necessary steps back, and 
now I can go forward, I hope :).

Thanks,
Janusz
