From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 17:05:26 +0200
Message-ID: <1274972726.27810.5144.camel@twins>
References: <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	 <1274867106.5882.5090.camel@twins>
	 <20100526120242.5c9b73ad@schatten.dmk.lab>
	 <AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	 <20100526133721.602633b2@schatten.dmk.lab>
	 <AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	 <20100526142430.327ccbc4@schatten.dmk.lab>
	 <20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	 <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	 <20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	 <20100527140655.GA28048@srcf.ucam.org>
	 <20100527160543.2228fc17@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:44276 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab0E0PFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 11:05:41 -0400
In-Reply-To: <20100527160543.2228fc17@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>

On Thu, 2010-05-27 at 16:05 +0100, Alan Cox wrote:
> What is the problem here - your device driver for the display can block
> tasks it doesn't want to use the display. 

Very well put again.

I bet the next example is a proglet that does: while(1); without device
interaction :-).
