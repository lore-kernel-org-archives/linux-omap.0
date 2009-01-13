From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 3/3] ASoC: Always syncronize audio transfers on frames
Date: Tue, 13 Jan 2009 10:21:47 +0200
Message-ID: <1231834907.13843.110.camel@eenurkka-desktop>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
	 <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
	 <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
	 <1231833140301-git-send-email-ext-eero.nurkkala@nokia.com>
	 <20090113101641.4d1c9a12.jarkko.nikula@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35427 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZAMIYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 03:24:49 -0500
In-Reply-To: <20090113101641.4d1c9a12.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, "ext Lopez Cruz, Misael" <x0052729@ti.com>

On Tue, 2009-01-13 at 10:16 +0200, Jarkko Nikula wrote:
> This is true (checked now :-)) that RFIG and XFIG are not defined for
> 34xx (and 2430 as well!) but writing doesn't have any effect since the
> bit is read only. But since it's marked reserved, then better to not
> write it.

Good. This particular register setting caused troubles on the very first
audio playback to never be played! =)

It needed the ASoC to finish the Damp, and after that, the thing was
good to go for good. Thus, I highly consider this as something that
is needed.

> If you can generate patch against Torvald's tree, i.e. 2.6.29-rc1 and
> send to alsa-devel, I can ack it.
> 
> 
> Jarkko

