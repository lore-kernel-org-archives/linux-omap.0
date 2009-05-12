From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C:Moving Register Defines to Header File
Date: Tue, 12 May 2009 16:13:05 +0300
Message-ID: <20090512130857.GL18349@scadufax.research.nokia.com>
References: <52671.192.168.10.89.1242133785.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52671.192.168.10.89.1242133785.squirrel-pJFUjGLopx31T2qfsofKZtBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 12, 2009 at 03:09:45PM +0200, ext Syed Rafiuddin wrote:
> This patch creates i2c-omap.h header and moves register and bit definition
> macros to it from i2c-omap.c
> 
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>

Any special need for that ? will those registers be accessed outside
i2c-omap.c ?? If not, I'd rather keep them in the c file.

BTW, this should go straight to Ben Dooks and i2c@vger. Adding them to
cc.

-- 
balbi
