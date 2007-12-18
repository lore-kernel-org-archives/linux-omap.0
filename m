From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resending PATCH 1/2] driver:twl4030-rtc specific code
Date: Mon, 17 Dec 2007 21:50:05 -0800
Message-ID: <20071218055005.GH739@atomide.com>
References: <20071217185944.GJ7388@atomide.com>
	<02b301c84139$2e7c0480$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <02b301c84139$2e7c0480$988818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Girish <girishsg@ti.com> [071217 21:45]:
>  
> Hi Tony,
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com] 
> 
> >
> >* Girish <girishsg@ti.com> [071216 21:53]:
> >> This patch adds rtc-twl4030 driver specific code.
> >
> >Almost ready.. Just few more things:
> >
> >- Please changes spaces to tabs to follow the CodingStyle
> 
> These spaces din't figure out when I ran checkpatch script, does checkpatch needs an upgrade for such kind of space checks? If yes I
> can try  sending a patch to the maintainer. 

Yeah, checkpatch does not check for that.. I guess it could check for
double spaces and warn about them. Might be a pain to include all the
rules for it though.

> >- Please change the subject to say "RTC: twl4030-rtc specific code"
> 
> I'll resend the patch with above comments fixed.

Thanks, that saves me some re-editing :)

Regards,

Tony
