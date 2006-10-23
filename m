From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] McBSP dependence for DSP on ARCH_OMAP1 is missing
Date: Mon, 23 Oct 2006 16:18:25 +0300
Message-ID: <20061023131824.GD22577@atomide.com>
References: <453931C6.9080209@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <453931C6.9080209@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Cohen <david.cohen@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Cohen <david.cohen@indt.org.br> [061020 23:34]:
> Hi,
> 
> I've tried to compile an up-to-dated kernel tree configured for h3. I
> got some errors due to the McBSP depends on OMAP_DSP if ARCH_OMAP1 is
> set, as we can see at these lines from "arch/arm/plat-omap/mcbsp.c":
> 
> (...)
> #ifdef CONFIG_ARCH_OMAP1
> static void omap_mcbsp_dsp_request(void)
> {
>     if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>         omap_dsp_request_mem();
> 
> (...)
> #endif
> (...)
> 
> So, I've made this minimal patch to deal with this problem. It worked
> well for me. But I put, also, CONFIG_OMAP_DSP=y as default on h3 config
> file to keep the OMAP_MCBSP as default too.

This should be already fixed in a recent patch:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=40749d1d5792748372ae3becf638944b896ef8f1

Regards,

Tony
