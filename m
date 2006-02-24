From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] OMAP1: camera core : Use platform driver structure
Date: Fri, 24 Feb 2006 02:35:50 -0800 (PST)
Message-ID: <20060224103550.28867.qmail@web32915.mail.mud.yahoo.com>
References: <304D2A85A9643F4A991BDDF8D297BBA602645AE0@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA602645AE0@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Zhang, Jian" <jzhang@ti.com> wrote:

> Komal,
> 
> Is there any guideline on the way a driver is registered with LDM?
> e.g.
> via driver_register() or platform_driver_register()? We are now
> always
> using omap_driver_register() which is a wrapper to driver_register().
> 
> Again, is this the trend to move the bulk of init code to probe()
> function?

This one is very tricky question :) May be GregKH and RMK can do better
justice :) 

But I don't understand the need for you to wrap-up the arch specific
register function around driver_register, may be you were defining your
bus type? I also feel, that this wrapper came much before in your
kernel (2.6.9 and .8 series) than the platform_driver addition. 

platform_driver structure does wraps the all the members except the
devid, bus and shared clocks, and devid can be assigned using the
platform_device structure, and bus assignment may not be required as we
connect them under common platform bus.  

And platform_driver_register does call driver_register similar to your
omap_driver_register with few more wrapper functions inside. But as
platform_driver interface wrappers was added recently (Nov'05) by RMK,
which allows to platform device driver methods to be passed a platform
device structure instead a plain device structure and which will
introduce casting in every platform driver. (Last sentence is copied
from RMK's patch comment :) ).

But using driver_register directly doesn't break anything yet.

> 
> If these are what other drivers do, I certainly don't want to see
> camera
> driver being different.
> 

I don't see this as 'must have' kind of things, but if I look back at
what my camera patch gained having those modifications as of current
state of usage for OMAP1610/1710 camera arch, it is 'nothing' except
(void *) casting.

Just FYI.

[1] http://lwn.net/Articles/161236/
[2] http://lwn.net/Articles/158747/
[3] http://lwn.net/Articles/158781/


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
