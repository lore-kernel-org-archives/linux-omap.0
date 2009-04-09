From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: 2.6.29 and SDP3430
Date: Thu, 9 Apr 2009 10:03:43 +0300
Message-ID: <20090409100343.71d34c16.jarkko.nikula@nokia.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31128 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbZDIHD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 03:03:26 -0400
In-Reply-To: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, 9 Apr 2009 08:45:00 +0200
ext Nishanth Menon <menon.nishanth@gmail.com> wrote:

> Hi Folks,
> 
> just messing around with tony's master branch on SDP3430, just did a
> defconfig and a build with  2007q3-51 codesourcery compiler, I see it
> hang around:
> 
Kernels built with this compiler stuck into delay loop calibration.
No idea why, but 2008q3-66 was working for me.


Jarkko
