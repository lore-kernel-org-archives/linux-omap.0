From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 17:12:44 +0200
Message-ID: <1274886764.1674.1756.camel@laptop>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	 <201005242049.18920.rjw@sisk.pl> <87wrusvrqe.fsf@deeprootsystems.com>
	 <201005250138.16293.rjw@sisk.pl> <1274863655.5882.4875.camel@twins>
	 <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	 <1274867106.5882.5090.camel@twins>
	 <20100526120242.5c9b73ad@schatten.dmk.lab>
	 <AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	 <20100526133721.602633b2@schatten.dmk.lab>
	 <AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	 <20100526142430.327ccbc4@schatten.dmk.lab>
	 <20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	 <20100526171106.0e44a736@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56802 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab0EZPMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 11:12:49 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1OHIHo-0000eo-My
	for linux-omap@vger.kernel.org; Wed, 26 May 2010 15:12:48 +0000
In-Reply-To: <20100526171106.0e44a736@schatten.dmk.lab>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>

On Wed, 2010-05-26 at 17:11 +0200, Florian Mickler wrote:
> > Implementation-wise it probably ties into setpidle, its simply that a task
> > has a pair of idle values, a dynamic one and a base one, the dynamic one
> > being the base one but updatable temporarily by drivers.

> How does this address the loss of wakeup events while using suspend? 
> (For example the 2 issues formulated by Alan Stern in [1])

By not suspending obviously.

