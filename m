From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Fri, 10 Jun 2016 18:15:26 +0200
Message-ID: <2592499.y1ehgT9o2a@saturn>
References: <201601091616.04193@pali> <86213272.dICX26rd7d@saturn> <20160610155940.GB28283@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610155940.GB28283@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri 10 June 2016 10:59:40 Bin Liu wrote:
> The musb ug says the testmde is not used in normal operation, so my
> opinion is force_host should not be used for hacking n900 host mode if
> this is for real product development or support.

You're aware N900 OS aka maemo is a) FOSS, and b) EOL at least from Nokia's 
POV? So there's neither "product development" nor any _'official'_ support 
involved.
And c) we (community) already _did_ use it since it was the only chance to 
make hostmode sort of work for N900, it's not like we could redesign N900 
hardware to support regular hostmode, we need to work with what RL gave us. 
It evades me why you discourage resp reject this established solution. 
Just Nokia not supporting hostmode evidently doesn't mean we can't get 
anything done, and I don't see why we should refrain from doing so.

/j
-- 
()  ascii ribbon campaign
/\  
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml          
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml    
http://www.gerstbach.at/2004/ascii/ (German)
