From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: MUSB Host problems
Date: Wed, 10 Jun 2009 08:12:48 +0300
Message-ID: <20090610081248.417f5d98.jhnikula@gmail.com>
References: <4A2E9FD5.9090807@mlbassoc.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F52BB6F3@dbde02.ent.ti.com>
	<4A2EA9CA.7070900@mlbassoc.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F52BB72D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:51861 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbZFJFMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 01:12:24 -0400
Received: by ewy6 with SMTP id 6so623904ewy.37
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 22:12:25 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F52BB72D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Gary Thomas <gary@mlbassoc.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 10 Jun 2009 07:55:17 +0530
"Pandita, Vikram" <vikram.pandita@ti.com> wrote:

> >>> similar to the Beagle).  When I startup, I get this message:
> >>>  Clock usbhost_48m_fck didn't enable in 100000 tries
> >>
> >> This is bad
> >
> >Why?  What does it mean?  How do I fix it?
> 
> The ehci driver on linux-omap works for Beagleboard and sdp.
> so this may not be a fatal problem
> 
Actually it's currently broken but issue is known:

http://marc.info/?l=linux-omap&m=124419824625121&w=2

-- 
Jarkko
