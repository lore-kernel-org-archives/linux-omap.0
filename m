From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RESEND #2] [PATCH v2] LEDS: Add output invertion option to
 backlight trigger
Date: Thu, 6 Jan 2011 13:08:56 -0800
Message-ID: <20110106130856.22b92a8b.randy.dunlap@oracle.com>
References: <201012091441.51846.jkrzyszt@tis.icnet.pl>
	<20110106130440.cfd77c8e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110106130440.cfd77c8e.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Richard Purdie <rpurdie@rpsys.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Jan 2011 13:04:40 -0800 Andrew Morton wrote:

> On Thu, 9 Dec 2010 14:41:50 +0100
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> 
> > +static DEVICE_ATTR(invert, 0644, bl_trig_invert_show, bl_trig_invert_store);
> 
> This new sysfs file should be documented.  Where would be an
> appropriate place for that?  Documentation/leds-class.txt doesn't
> mention a sysfs API at all.  
> --

in Documentation/ABI/, where all sysfs interface info lives.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
