From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [ANNOUNCE] cpupowerutils - cpufrequtils extended with quite
 some features
Date: Sat, 12 Mar 2011 12:40:10 +0800
Message-ID: <20110312044010.GB3634@zhy>
References: <201103111247.00212.trenn@suse.de>
 <20110312043409.GA3634@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110312043409.GA3634@zhy>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, discuss@lesswatts.org, power@bughost.org, cpufreq@vger.kernel.org, linux@dominikbrodowski.net, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, herrmann.der.user@googlemail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 12, 2011 at 12:34:09PM +0800, Yong Zhang wrote:
> On Fri, Mar 11, 2011 at 12:46:59PM +0100, Thomas Renninger wrote:
> > Happy testing..., if you have a recent machine, you'll like it!
> > 
> > After some testing phase it would be great to get this tool
> > merged into the kernel git repo under:
> > tools/power/cpupower
> > and replace the Intel HW only supporting tools in tools/power/x86.
> 
> I got below output on my laptop:
> 
>     |Mperf               || Idle_Stats                
> CPU | C0   | Cx   | Freq || POLL | C1   | C2   | C3   
>    0| 36.00| 64.00|   820||1843411670376227.2|1843411670376692.2|  0.00|  0.00
>    1| 44.69| 55.31|   920||  0.00|  0.00|  0.00|  0.00
> 
> Seems below patch fix it:

forget the declaration of value :)

---
--- utils/helpers/sysfs-orig.c	2011-03-12 12:32:06.179827929 +0800
+++ utils/helpers/sysfs.c	2011-03-12 12:35:21.512796546 +0800
@@ -111,7 +111,7 @@
 						     unsigned int idlestate,
 						     enum idlestate_value which)
 {
-	unsigned long value;
+	unsigned long long value;
 	unsigned int len;
 	char linebuf[MAX_LINE_LEN];
 	char *endp;
@@ -126,7 +126,7 @@
 		return 0;
 	}
 
-	value = strtoul(linebuf, &endp, 0);
+	value = strtoull(linebuf, &endp, 0);
 
 	if ( endp == linebuf || errno == ERANGE )
 		return 0;
