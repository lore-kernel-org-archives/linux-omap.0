From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Wed, 27 Aug 2008 15:14:55 -0700
Message-ID: <5e088bd90808271514x56dd5748g41aa0ff04232cb2f@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
	 <5e088bd90808261018h1e04cbd4o20e88669031eda4d@mail.gmail.com>
	 <20080827093849.c047b6eb.jarkko.nikula@nokia.com>
	 <5e088bd90808270639o1d0ba027r4d6ed9683d68fea2@mail.gmail.com>
	 <5e088bd90808271357q7edd7cf6u4c7fb265d24dcb79@mail.gmail.com>
	 <A7898046-17E7-4E11-A8CE-B14E24D95FF9@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:24957 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYH0WO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 18:14:56 -0400
Received: by py-out-1112.google.com with SMTP id p76so48760pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 15:14:55 -0700 (PDT)
In-Reply-To: <A7898046-17E7-4E11-A8CE-B14E24D95FF9@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> could  you try removing /etc/asound.conf, it is set to dmix by default,
> which might screw things up.

Sadly, no effect.  Same crash.

Steve
