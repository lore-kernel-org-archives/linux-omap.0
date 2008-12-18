From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: GPIO switch framework (was: Re: [PATCH] ARM: OMAP: Add support
	for dynamic GPIO switch update)
Date: Thu, 18 Dec 2008 15:40:49 +0200
Message-ID: <1229607649.5895.438.camel@jani-desktop>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215134010.GA10709@mail.solidboot.com>
	 <1229352752.5895.325.camel@jani-desktop>
	 <20081215152920.GA11007@mail.solidboot.com>
	 <1229356723.5895.348.camel@jani-desktop>
	 <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com>
	 <1229600573.5895.432.camel@jani-desktop>
	 <5d5443650812180500j67647a34mf8eb99c1f4b24c0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54305 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYLRNk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 08:40:59 -0500
In-Reply-To: <5d5443650812180500j67647a34mf8eb99c1f4b24c0a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: ext Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Thu, 2008-12-18 at 18:30 +0530, ext Trilok Soni wrote:

> Why limit to GPIO based switches only? GPIOs should be client of
> switch framework I think, and how h/w implements that switch should be
> hidden by client specific driver.

You're quite right, it's better not to make such unnecessary
limitations. All the more reason to discuss before anyone submits a
truckload of patches for review. :)

Jani.


