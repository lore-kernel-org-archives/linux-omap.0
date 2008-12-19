From: Brian Swetland <swetland@google.com>
Subject: Re: GPIO switch framework (was: Re: [PATCH] ARM: OMAP: Add support
	for dynamic GPIO switch update)
Date: Fri, 19 Dec 2008 00:51:27 -0800
Message-ID: <20081219085127.GB1530@bulgaria.corp.google.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com> <20081215134010.GA10709@mail.solidboot.com> <1229352752.5895.325.camel@jani-desktop> <20081215152920.GA11007@mail.solidboot.com> <1229356723.5895.348.camel@jani-desktop> <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com> <1229600573.5895.432.camel@jani-desktop> <5d5443650812180500j67647a34mf8eb99c1f4b24c0a@mail.gmail.com> <1229607649.5895.438.camel@jani-desktop> <5d5443650812190047u7c22ff96y2f4503827075ea43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:6454 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYLSIwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 03:52:08 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650812190047u7c22ff96y2f4503827075ea43@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, ext Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net


Definitely worth discussing -- I'm going to be out of the office for two
weeks over the holidays, and most of the rest of our team is on vacation
as well.  I'll pass this on, but I'm not sure if people will have much
time to take a look before January.

[Trilok Soni <soni.trilok@gmail.com>]
> Hi Jani,
> 
> On Thu, Dec 18, 2008 at 7:10 PM, Jani Nikula
> <ext-jani.1.nikula@nokia.com> wrote:
> > On Thu, 2008-12-18 at 18:30 +0530, ext Trilok Soni wrote:
> >
> >> Why limit to GPIO based switches only? GPIOs should be client of
> >> switch framework I think, and how h/w implements that switch should be
> >> hidden by client specific driver.
> >
> > You're quite right, it's better not to make such unnecessary
> > limitations. All the more reason to discuss before anyone submits a
> > truckload of patches for review. :)
> 
> Let me CC Brian from Android here.
> 
> Brian, we are discussing here of making generic switch framework and
> android-kernel also have near to generic switch fwk implementation, so
> that we can combine the linux-omap gpio switch fwk ideas and android
> one to create generic switch framework.
> 
> For complete thread information, please start from this link:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg07845.html
> 
> -- 
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
