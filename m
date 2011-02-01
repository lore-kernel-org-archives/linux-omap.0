From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCHv4] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Tue, 1 Feb 2011 14:23:42 -0800
Message-ID: <20110201222342.GA19137@suse.de>
References: <1296545441-17070-1-git-send-email-weber@corscience.de>
 <87ei7ryavx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ei7ryavx.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, open list <linux-kernel@vger.kernel.org>, Thomas Weber <weber@corscience.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 01, 2011 at 08:31:30AM -0800, Kevin Hilman wrote:
> Thomas Weber <weber@corscience.de> writes:
> 
> > Magic SysRq key is not working for OMAP on new serial
> > console ttyOx because SUPPORT_SYSRQ is not defined
> > for omap-serial.
> >
> > This patch defines SUPPORT_SYSRQ in omap-serial and
> > enables handling of Magic SysRq character.
> >
> > Further there is an issue of losing first break character.
> > Removing the reset of the lsr_break_flag fixes this issue.
> >
> > Signed-off-by: Thomas Weber <weber@corscience.de>
> > Acked-by: Govindraj.R <govindraj.raja@ti.com>
> > Tested-by: Manjunath G Kondaiah <manjugk@ti.com>
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Greg,
> 
> Will you be taking this?  If you prefer, we can take it via OMAP tree
> with your ack.

I can take it if it's not a problem for you.  Or if you want to, please
add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patch.

Let me know which is easier for you.

thanks,

greg k-h
