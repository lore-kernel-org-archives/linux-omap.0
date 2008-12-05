From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Remove drivers/input/touchscreen/omap directory?
Date: Fri, 5 Dec 2008 16:34:20 +0200
Message-ID: <20081205163420.c607293d.jarkko.nikula@nokia.com>
References: <5d5443650812050555j276aa797j3322254a5fa89e8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46051 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbYLEOet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 09:34:49 -0500
In-Reply-To: <5d5443650812050555j276aa797j3322254a5fa89e8d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, 5 Dec 2008 19:25:48 +0530
"ext Trilok Soni" <soni.trilok@gmail.com> wrote:

> Hi Tony,
> 
> I think no one using touchscreen drivers under this directory, please remove.
> 
> I will start process of sending tscXXXX patches to upstream soon...
> 
That's great! Also drivers/spi/tsc2301-mixer.c can be removed in part
of the process.


Jarkko
