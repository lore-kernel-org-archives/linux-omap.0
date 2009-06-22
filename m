From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 22 Jun 2009 14:47:57 +0300
Message-ID: <20090622144757.f78373ae.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200906030924.14230.jkrzyszt@tis.icnet.pl>
	<20090605165531.7d0c4522.jhnikula@gmail.com>
	<200906060028.01600.jkrzyszt@tis.icnet.pl>
	<20090608094028.415e6ec3.jhnikula@gmail.com>
	<4A2E7921.7090200@tis.icnet.pl>
	<4A364B1A.5040905@tis.icnet.pl>
	<20090615181633.4570426f.jhnikula@gmail.com>
	<4A37AFA9.4080403@tis.icnet.pl>
	<20090618090712.8f8ecd53.jhnikula@gmail.com>
	<4A3A27C8.60005@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:24889 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbZFVLrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:47:17 -0400
In-Reply-To: <4A3A27C8.60005@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Thu, 18 Jun 2009 13:40:56 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Then I retired the same on the commit 
> d8376cc482b241701f7606c81ad578b90853e175 and got similiar hangup.
> Next, I moved mcbsp initialization to a boot time hook and finally
> heard a sound and got my first DMA interrupt!
> 
Great! :-)

I wonder what special boot time omap_mcbsp_request call has in respect
to McBSP access. DSP issue pointed by Tony might be one answer and I'm
also thinking can it be also some clock gating problem to the McBSP like
some parent clock gets idled after booting?

Can you move this boot time initialization moment around with
xxx_initcall variants to see what is the point where block is not
anymore accessable? Basically around the DSP power up and idle code
(were there such code for older audio drivers?) and where unused clocks
are disabled (functions clk_disable_unused and
omap1_clk_disable_unused).


-- 
Jarkko
