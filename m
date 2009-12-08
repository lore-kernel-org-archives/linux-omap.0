From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: eac and mcbsp for omap850
Date: Tue, 8 Dec 2009 15:05:47 +0200
Message-ID: <20091208150547.a83f0e81.jhnikula@gmail.com>
References: <e7c6a05e0912080406y763b2e99nd0188ff1911ec829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47272 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbZLHNEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 08:04:32 -0500
Received: by bwz27 with SMTP id 27so4337528bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 08 Dec 2009 05:04:38 -0800 (PST)
In-Reply-To: <e7c6a05e0912080406y763b2e99nd0188ff1911ec829@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tue, 8 Dec 2009 13:06:05 +0100
Belisko Marek <marek.belisko@gmail.com> wrote:

> Hi,
> 
> I would like to rewrite old eac audio driver for omap730 to current
> ASoc implementation
> but as I can understand new implementation use McBsP to
> transfer data to codec. Could this approach be used in omap850 which
> use EAC like codec and data from memory is transfered via DMA?
> 
Basically it should be possible to develop a new ASoC DAI driver using
EAC. Even currently there is only one McBSP based DAI driver
sound/soc/omap/omap-mcbsp.c, there is no restrictions to develop another
DAI drivers since the sound/soc/omap/omap-pcm.c is not tied to
underlying DAI.

-- 
Jarkko
