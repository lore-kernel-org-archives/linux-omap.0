From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Fri, 17 Aug 2007 14:14:56 -0400
Message-ID: <31e679430708171114o565ee910o2002a0bf98865c90@mail.gmail.com>
References: <46C5C233.5090405@googlemail.com>
	<31e679430708170912p1bd8050dg38db45d14d237961@mail.gmail.com>
	<46C5CF29.2020601@googlemail.com>
	<200708170957.44311.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708170957.44311.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 8/17/07, David Brownell <david-b@pacbell.net> wrote:
> > this doesn't look right since any device can issue SRP. It's better
> > for you to use it somewhere on DaVinci.
>
> That "issue SRP" attribute has no business being specific to any
> particular platform.
>

This is needed during USB OTG Compliance program... and it looks to me
really architecture dependent, if you have a better way for doing
this, please tell me and I'll try it.


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
