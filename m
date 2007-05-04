From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Re: [PATCH] Fix mis-reporting USB Mode on sysfs
Date: Fri, 4 May 2007 09:02:16 +0300
Message-ID: <20070504060216.GB5850@1BRL00624.research.nokia.com>
References: <31e679430705031244rc7018b8o5cf0025e63058b3b@mail.gmail.com>
	<20070503201158.GJ28985@atomide.com>
Reply-To: ext-felipe.lima@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070503201158.GJ28985@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 03, 2007 at 08:11:59PM +0000, ext Tony Lindgren wrote:
> * Felipe Balbi <felipebalbi@users.sourceforge.net> [070503 19:45]:
> > 	This small patch fixes the mode reporting on sysfs.
> > 	Whithout this, we will always see the device as in
> > 	otg mode.
> 
> Hmmm, it should not be necessary to change the mode here as if the
> mode changes, the interrupt should set it correctly.
> 
> Maybe should have some additional modes though:
> 
> host
> peripheral
> otg_host
> otg_peripheral

yeah, tought about it but didn't wanna change so much the current code.

anyway, i'll check this and provide a better patch then.

> 
> I guess host and peripheral should be possible to compile in without
> OTG eventually. And if just say otg, we don't know if it's currently
> host or peripheral.
> 
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

Kernel Developers Team
