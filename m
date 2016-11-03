From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Thu, 3 Nov 2016 23:01:02 +0100
Message-ID: <20161103220102.GA28425@localhost.localdomain>
References: <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
 <20161027184507.GM12024@localhost>
 <20161027191552.tuutyslp5qtu2b4f@atomide.com>
 <20161028094428.GO12024@localhost>
 <20161028181318.umwn3rx55pg2cvwd@atomide.com>
 <20161031114921.GB4254@localhost>
 <20161103212635.GC21430@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103212635.GC21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 03, 2016 at 02:26:35PM -0700, Tony Lindgren wrote:
[snip]
> Here's the patch updated to use the existing finish_resume_work.
> Is that along the lines you were thinking?
> 
> Adding also Ladis to Cc too.

Just gave it a try. Sure it wasn't supposed to fix "musb with hub"
issue, but at least it doesn not make things worse :-)

	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
