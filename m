From: David Brownell <david-b@pacbell.net>
Subject: Re: Overo broken with current top of tree
Date: Thu, 30 Apr 2009 03:23:55 -0700
Message-ID: <200904300323.55674.david-b@pacbell.net>
References: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com> <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:36660 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751187AbZD3KYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Apr 2009 06:24:07 -0400
In-Reply-To: <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@sirena.org.uk>

On Thursday 30 April 2009, Grazvydas Ignotas wrote:
> I get the same on pandora, although it continues booting fine after
> that. Maybe regulator folks will comment about regulator errors.

Does mainline 3e59091828ed5406c879b899b4257fcef7271e2c
resolve it for you?
