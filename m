From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 05:24:11 -0700
Message-ID: <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com>
	 <20080917082043.04c94e2d.jarkko.nikula@nokia.com>
	 <200809162255.00918.david-b@pacbell.net>
	 <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:23341 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYIQMYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 08:24:13 -0400
Received: by py-out-1112.google.com with SMTP id p76so2385787pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 05:24:11 -0700 (PDT)
In-Reply-To: <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi <k.kooi@student.utwente.nl> wrote:

> And they aren't working too well with current l-o git either with MUSB being
> broken. There's a patch to fix client mode, but host mode still isn't
> working.

Host mode musb is working just fine on Overo with the "set
transceiver" patch.  Not sure why you are having trouble with Beagle
(and can't check since I don't have my Beagle board with me at the
moment)

Steve
