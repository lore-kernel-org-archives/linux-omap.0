From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] alsa: add Beagleboard SoC configuration.
Date: Wed, 17 Sep 2008 05:15:37 -0700
Message-ID: <5e088bd90809170515n78d7b787ofc59fddffaad2cd5@mail.gmail.com>
References: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:8260 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbYIQMPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 08:15:38 -0400
Received: by py-out-1112.google.com with SMTP id p76so2382898pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 05:15:37 -0700 (PDT)
In-Reply-To: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>

On Tue, Sep 16, 2008 at 1:51 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This is exactly the same as the overo configuration. It might make sense
> to have them in a single one.

I plan to add support for additional input channels on Overo that are
not present on Beagle, so I think separate machine files makes sense
in the long run.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Acked-by: Steve Sakoman <steve@sakoman.com>

Steve
