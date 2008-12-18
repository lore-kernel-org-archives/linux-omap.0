From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: GPIO switch framework (was: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update)
Date: Thu, 18 Dec 2008 18:30:17 +0530
Message-ID: <5d5443650812180500j67647a34mf8eb99c1f4b24c0a@mail.gmail.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215134010.GA10709@mail.solidboot.com>
	 <1229352752.5895.325.camel@jani-desktop>
	 <20081215152920.GA11007@mail.solidboot.com>
	 <1229356723.5895.348.camel@jani-desktop>
	 <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com>
	 <1229600573.5895.432.camel@jani-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:20233 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYLRNAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 08:00:18 -0500
Received: by wf-out-1314.google.com with SMTP id 27so447328wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 18 Dec 2008 05:00:17 -0800 (PST)
In-Reply-To: <1229600573.5895.432.camel@jani-desktop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: =?ISO-8859-1?Q?ext_Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

Hi Jani,

On Thu, Dec 18, 2008 at 5:12 PM, Jani Nikula
<ext-jani.1.nikula@nokia.com> wrote:
> On Tue, 2008-12-16 at 11:35 +0530, ext Trilok Soni wrote:
>
>> OK, I found other guys (android ??) using such home brew frameworks.
>> Time to write a switch framework.
>
> To start a discussion on what such a GPIO switch framework should be
> like if someone were to write it, here's a list of the kind of things
> I'd like to see in it (mostly from gpio-switch.c):

Why limit to GPIO based switches only? GPIOs should be client of
switch framework I think, and how h/w implements that switch should be
hidden by client specific driver.

>
> * Based on or integrated in the gpiolib.

gpio-switch-client would do that. Main framework just provides the
generic operations hooks.

>
> * Dynamically changeable notification callbacks in kernel.

>
> * Sysfs notifications to userspace.
>

Yes, possible to through uevents, android-switch framework does that.

> * Debouncing for the notifications to filter spurious events.
>
> * Dynamically adjustable debounce timeouts.
>
> * Arbitrary names for the GPIOs in sysfs instead of (or in addition to)
> the gpiolib style "gpioN".

It is left to gpio-switch-client to provide good names to switch
framework which can be exposed by main framework through sysfs. So,
users of this files in userspace doesn't care if it is gpio or
something else.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
