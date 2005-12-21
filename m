From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: build error on Linux-2.6.15-rc4-omap1
Date: Tue, 20 Dec 2005 18:06:12 -0800
Message-ID: <43A8B894.3060204@mvista.com>
References: <20051221.102534.78702175.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051221.102534.78702175.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hiroki Kaminaga wrote:
..
> make[2]: *** No rule to make target `arch/arm/mach-omap1/pm.o', needed by `arch/arm/mach-omap1/built-in.o'.  Stop.
> make[1]: *** [arch/arm/mach-omap1] Error 2
>..
> I'm currently doing work-around by making symbolic link from plat-omap/pm.c.
> 
> Anyone have same build error?

Yes, I now remember I just worked around it and forgot to send a patch 
here.  I assume pm.c is being moved from plat-omap to mach-omap1 (and a 
future version is destined for mach-omap2), so a patch to move the 
current file to mach-omap1 is needed?

-- 
Todd
